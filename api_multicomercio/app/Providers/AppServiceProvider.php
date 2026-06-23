<?php

namespace App\Providers;

use Google\Cloud\Storage\StorageClient;
use Illuminate\Filesystem\FilesystemAdapter;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\ServiceProvider;
use League\Flysystem\Filesystem;
use League\Flysystem\GoogleCloudStorage\GoogleCloudStorageAdapter;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        Storage::extend('gcs', function (Application $app, array $config) {
            $client = new StorageClient([
                'projectId'   => $config['project_id'],
                'keyFilePath' => $config['key_file'],
            ]);

            $bucketName = $config['bucket'];
            $bucket     = $client->bucket($bucketName);

            $adapter = new class($bucket, $config['path_prefix'] ?? '') extends GoogleCloudStorageAdapter {
                public string $bucketName = '';

                public function getUrl(string $path): string
                {
                    return 'https://firebasestorage.googleapis.com/v0/b/'
                        . $this->bucketName . '/o/'
                        . rawurlencode($path) . '?alt=media';
                }
            };
            $adapter->bucketName = $bucketName;

            return new FilesystemAdapter(
                new Filesystem($adapter, ['visibility' => $config['visibility'] ?? 'public']),
                $adapter,
                $config
            );
        });
    }
}
