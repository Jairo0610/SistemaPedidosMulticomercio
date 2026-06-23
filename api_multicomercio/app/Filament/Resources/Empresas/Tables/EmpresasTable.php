<?php

namespace App\Filament\Resources\Empresas\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class EmpresasTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('logo_url')
                    ->label('Logo')
                    ->getStateUsing(fn ($record) => $record->logo_url
                        ? 'https://firebasestorage.googleapis.com/v0/b/'
                            . config('filesystems.disks.firebase.bucket')
                            . '/o/' . rawurlencode($record->logo_url)
                            . '?alt=media'
                        : null)
                    ->extraImgAttributes([
                        'style' => 'background:#ffffff;border-radius:8px;padding:6px;object-fit:contain;',
                    ]),
                TextColumn::make('nombre')
                    ->searchable(),
                TextColumn::make('categoria.nombre')
                    ->label('Categoría')
                    ->sortable(),
                TextColumn::make('user.name')
                    ->label('Propietario')
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
