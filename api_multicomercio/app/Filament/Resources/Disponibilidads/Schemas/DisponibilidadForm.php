<?php

namespace App\Filament\Resources\Disponibilidads\Schemas;

use App\Models\Producto;
use App\Models\Sucursal;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class DisponibilidadForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('sucursal_id')
                    ->label('Sucursal')
                    ->options(function () {
                        if (auth()->user()?->rol === 'empresa') {
                            $empresaId = auth()->user()->empresa?->id;
                            return Sucursal::where('empresa_id', $empresaId)->pluck('nombre', 'id');
                        }
                        return Sucursal::with('empresa')
                            ->get()
                            ->mapWithKeys(fn ($s) => [$s->id => "{$s->nombre} ({$s->empresa->nombre})"]);
                    })
                    ->required()
                    ->searchable(),
                Select::make('producto_id')
                    ->label('Producto')
                    ->options(function () {
                        if (auth()->user()?->rol === 'empresa') {
                            $empresaId = auth()->user()->empresa?->id;
                            return Producto::where('empresa_id', $empresaId)->pluck('nombre', 'id');
                        }
                        return Producto::orderBy('nombre')->pluck('nombre', 'id');
                    })
                    ->required()
                    ->searchable(),
                TextInput::make('stock')
                    ->required()
                    ->numeric()
                    ->default(0),
                TextInput::make('stock_minimo')
                    ->label('Stock mínimo')
                    ->required()
                    ->numeric()
                    ->default(0),
                Toggle::make('disponible')
                    ->required(),
            ]);
    }
}
