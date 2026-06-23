<?php

namespace App\Filament\Resources\Sucursals\Schemas;

use App\Models\Empresa;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class SucursalForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('empresa_id')
                    ->label('Empresa')
                    ->options(function () {
                        if (auth()->user()?->rol === 'empresa') {
                            return Empresa::where('user_id', auth()->id())->pluck('nombre', 'id');
                        }
                        return Empresa::orderBy('nombre')->pluck('nombre', 'id');
                    })
                    ->required()
                    ->searchable(),
                TextInput::make('nombre')
                    ->required(),
                TextInput::make('direccion')
                    ->required(),
                TextInput::make('latitud')
                    ->required()
                    ->numeric(),
                TextInput::make('longitud')
                    ->required()
                    ->numeric(),
                TextInput::make('telefono')
                    ->tel()
                    ->default(null),
                Toggle::make('activa')
                    ->required(),
            ]);
    }
}
