<?php

namespace App\Filament\Resources\Categorias\Pages;

use App\Filament\Resources\Categorias\CategoriaResource;
use Filament\Resources\Pages\CreateRecord;

class CreateCategoria extends CreateRecord
{
    protected static string $resource = CategoriaResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['icono_url'] = $data['icono_nuevo'] ?? null;
        unset($data['icono_nuevo']);
        return $data;
    }
}
