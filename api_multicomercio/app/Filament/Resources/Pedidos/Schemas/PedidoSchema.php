<?php

namespace App\Filament\Resources\Pedidos\Schemas;

use Carbon\Carbon;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class PedidoSchema
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Información del pedido')
                    ->columns(2)
                    ->schema([
                        TextInput::make('numero')
                            ->label('N° pedido')
                            ->disabled(),

                        TextInput::make('created_at')
                            ->label('Fecha')
                            ->formatStateUsing(fn ($state) => $state ? Carbon::parse($state)->format('d/m/Y H:i') : null)
                            ->disabled(),

                        TextInput::make('user_id')
                            ->label('Cliente')
                            ->formatStateUsing(fn ($record) => $record?->user?->name)
                            ->disabled(),

                        TextInput::make('empresa_id')
                            ->label('Empresa')
                            ->formatStateUsing(fn ($record) => $record?->empresa?->nombre)
                            ->disabled(),

                        TextInput::make('sucursal_id')
                            ->label('Sucursal')
                            ->formatStateUsing(fn ($record) => $record?->sucursal?->nombre)
                            ->disabled(),

                        TextInput::make('modalidad_entrega')
                            ->label('Modalidad de entrega')
                            ->disabled(),

                        TextInput::make('metodo_pago')
                            ->label('Método de pago')
                            ->disabled(),

                        TextInput::make('total')
                            ->label('Total')
                            ->prefix('$')
                            ->disabled(),
                    ]),

                Section::make('Estados')
                    ->columns(2)
                    ->schema([
                        TextInput::make('estado_entrega')
                            ->label('Estado de entrega')
                            ->disabled(),

                        TextInput::make('estado_pago')
                            ->label('Estado de pago')
                            ->disabled(),
                    ]),

                Section::make('Entrega a domicilio')
                    ->columns(2)
                    ->schema([
                        TextInput::make('direccion_entrega')
                            ->label('Dirección')
                            ->disabled()
                            ->columnSpanFull(),

                        TextInput::make('latitud_entrega')
                            ->label('Latitud')
                            ->disabled(),

                        TextInput::make('longitud_entrega')
                            ->label('Longitud')
                            ->disabled(),
                    ])
                    ->hidden(fn ($record) => $record?->modalidad_entrega !== 'domicilio'),
            ]);
    }
}
