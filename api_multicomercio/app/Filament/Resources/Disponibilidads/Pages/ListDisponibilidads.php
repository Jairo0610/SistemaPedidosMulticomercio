<?php

namespace App\Filament\Resources\Disponibilidads\Pages;

use App\Filament\Resources\Disponibilidads\DisponibilidadResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListDisponibilidads extends ListRecords
{
    protected static string $resource = DisponibilidadResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
