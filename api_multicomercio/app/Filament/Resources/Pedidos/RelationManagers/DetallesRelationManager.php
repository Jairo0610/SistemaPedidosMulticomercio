<?php

namespace App\Filament\Resources\Pedidos\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class DetallesRelationManager extends RelationManager
{
    protected static string $relationship = 'detalles';

    protected static ?string $title = 'Detalle del pedido';

    public function form(Schema $schema): Schema
    {
        return $schema->components([]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('producto.nombre')
                    ->label('Producto'),

                TextColumn::make('cantidad')
                    ->label('Cant.'),

                TextColumn::make('precio_unitario')
                    ->label('Precio unit.')
                    ->money('USD'),

                TextColumn::make('subtotal')
                    ->label('Subtotal')
                    ->money('USD'),
            ])
            ->paginated(false)
            ->headerActions([])
            ->actions([])
            ->bulkActions([]);
    }
}
