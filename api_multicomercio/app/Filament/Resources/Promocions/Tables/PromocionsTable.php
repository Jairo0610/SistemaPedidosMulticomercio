<?php

namespace App\Filament\Resources\Promocions\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class PromocionsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('empresa.nombre')
                    ->label('Empresa')
                    ->sortable(),
                TextColumn::make('nombre')
                    ->searchable(),
                TextColumn::make('tipo')
                    ->badge()
                    ->color(fn (string $state) => match ($state) {
                        'porcentaje' => 'info',
                        'monto_fijo' => 'success',
                    }),
                TextColumn::make('valor')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('fecha_inicio')
                    ->label('Inicio')
                    ->date()
                    ->sortable(),
                TextColumn::make('fecha_fin')
                    ->label('Fin')
                    ->date()
                    ->sortable(),
                IconColumn::make('activa')
                    ->boolean(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
