<?php

namespace App\Filament\Resources\Productos\Pages;

use App\Filament\Resources\Productos\ProductoResource;
use Filament\Resources\Pages\CreateRecord;

class CreateProducto extends CreateRecord
{
    protected static string $resource = ProductoResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['imagen_url'] = $data['imagen_nueva'] ?? null;
        unset($data['imagen_nueva']);
        return $data;
    }
}
