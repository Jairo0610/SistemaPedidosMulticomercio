<?php

namespace App\Filament\Resources\Empresas\Pages;

use App\Filament\Resources\Empresas\EmpresaResource;
use Filament\Resources\Pages\CreateRecord;

class CreateEmpresa extends CreateRecord
{
    protected static string $resource = EmpresaResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['logo_url'] = $data['logo_nuevo'] ?? null;
        unset($data['logo_nuevo']);
        return $data;
    }
}
