<?php

namespace App\Filament\Resources\Productos\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ForceDeleteBulkAction;
use Filament\Actions\RestoreBulkAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\TrashedFilter;
use Filament\Tables\Table;

class ProductosTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('imagen_url')
                    ->label('Imagen')
                    ->getStateUsing(fn ($record) => $record->imagen_url
                        ? 'https://firebasestorage.googleapis.com/v0/b/'
                            . config('filesystems.disks.firebase.bucket')
                            . '/o/' . rawurlencode($record->imagen_url)
                            . '?alt=media'
                        : null)
                    ->extraImgAttributes([
                        'style' => 'background:#ffffff;border-radius:8px;padding:6px;object-fit:contain;',
                    ]),
                TextColumn::make('nombre')
                    ->searchable(),
                TextColumn::make('empresa.nombre')
                    ->label('Empresa')
                    ->sortable(),
                TextColumn::make('subcategoria.nombre')
                    ->label('Subcategoría')
                    ->sortable(),
                TextColumn::make('precio')
                    ->money('USD')
                    ->sortable(),
                IconColumn::make('activo')
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
                TrashedFilter::make(),
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                    ForceDeleteBulkAction::make(),
                    RestoreBulkAction::make(),
                ]),
            ]);
    }
}
