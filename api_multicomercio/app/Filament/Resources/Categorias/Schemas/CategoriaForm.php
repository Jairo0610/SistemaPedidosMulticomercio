<?php

namespace App\Filament\Resources\Categorias\Schemas;

use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;
use Illuminate\Support\HtmlString;

class CategoriaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nombre')
                    ->required(),
                TextInput::make('descripcion')
                    ->default(null),

                // Muestra la imagen actual con <img> (sin fetch, sin CORS)
                Placeholder::make('icono_actual')
                    ->label('Ícono actual')
                    ->content(function ($record): HtmlString|string {
                        if (!$record?->icono_url) {
                            return 'Sin imagen';
                        }
                        $bucket = config('filesystems.disks.firebase.bucket');
                        $url = 'https://firebasestorage.googleapis.com/v0/b/'
                            . $bucket . '/o/' . rawurlencode($record->icono_url)
                            . '?alt=media';
                        return new HtmlString(
                            '<style>.icono-pv{background:#fff}.dark .icono-pv{background:#374151}</style>'
                            . '<div class="icono-pv" style="display:inline-flex;border-radius:8px;padding:6px;">'
                            . '<img src="' . e($url) . '" style="height:48px;width:auto;object-fit:contain;">'
                            . '</div>'
                        );
                    })
                    ->hidden(fn ($record) => !$record?->icono_url),

                // Campo limpio solo para subir nueva imagen — FilePond nunca precarga nada
                FileUpload::make('icono_nuevo')
                    ->label('Subir nuevo ícono')
                    ->image()
                    ->disk('firebase')
                    ->directory('categorias')
                    ->fetchFileInformation(false),

                Toggle::make('activa')
                    ->required(),
            ]);
    }
}
