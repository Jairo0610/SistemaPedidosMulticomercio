<?php

namespace App\Filament\Resources\Promocions\Schemas;

use App\Models\Empresa;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class PromocionForm
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
                Textarea::make('descripcion')
                    ->default(null)
                    ->columnSpanFull(),
                Select::make('tipo')
                    ->options([
                        'porcentaje' => 'Porcentaje (%)',
                        'monto_fijo' => 'Monto fijo ($)',
                    ])
                    ->required(),
                TextInput::make('valor')
                    ->required()
                    ->numeric(),
                DateTimePicker::make('fecha_inicio')
                    ->label('Fecha inicio')
                    ->required(),
                DateTimePicker::make('fecha_fin')
                    ->label('Fecha fin')
                    ->required(),
                Toggle::make('activa')
                    ->required(),
            ]);
    }
}
