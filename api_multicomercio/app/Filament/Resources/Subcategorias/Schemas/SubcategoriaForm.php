<?php

namespace App\Filament\Resources\Subcategorias\Schemas;

use App\Models\Empresa;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class SubcategoriaForm
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
                TextInput::make('orden')
                    ->numeric()
                    ->default(0),
            ]);
    }
}
