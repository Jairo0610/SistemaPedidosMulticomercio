<?php

namespace App\Filament\Resources\Disponibilidads\Pages;

use App\Filament\Resources\Disponibilidads\DisponibilidadResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditDisponibilidad extends EditRecord
{
    protected static string $resource = DisponibilidadResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
