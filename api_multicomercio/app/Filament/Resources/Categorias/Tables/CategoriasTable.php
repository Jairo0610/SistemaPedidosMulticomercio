<?php

namespace App\Filament\Resources\Categorias\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class CategoriasTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('nombre')
                    ->searchable(),
                TextColumn::make('descripcion')
                    ->searchable(),
                ImageColumn::make('icono_url')
                    ->label('Ícono')
                    ->getStateUsing(fn ($record) => $record->icono_url
                        ? 'https://firebasestorage.googleapis.com/v0/b/'
                            . config('filesystems.disks.firebase.bucket')
                            . '/o/' . rawurlencode($record->icono_url)
                            . '?alt=media'
                        : null)
                    ->extraImgAttributes([
                        'style' => 'background:#ffffff;border-radius:8px;padding:6px;object-fit:contain;',
                    ]),
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
