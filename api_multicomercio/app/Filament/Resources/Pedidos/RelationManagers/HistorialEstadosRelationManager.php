<?php

namespace App\Filament\Resources\Pedidos\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class HistorialEstadosRelationManager extends RelationManager
{
    protected static string $relationship = 'historialEstados';

    protected static ?string $title = 'Historial de estados';

    public function form(Schema $schema): Schema
    {
        return $schema->components([]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('estado')
                    ->label('Estado')
                    ->badge()
                    ->color(fn (string $state) => match ($state) {
                        'nuevo'             => 'gray',
                        'en_preparacion'    => 'warning',
                        'en_camino'         => 'info',
                        'listo_para_retiro' => 'info',
                        'entregado'         => 'success',
                        'pendiente'         => 'warning',
                        'pagado'            => 'success',
                        default             => 'gray',
                    }),

                TextColumn::make('observacion')
                    ->label('Observación')
                    ->default('—'),

                TextColumn::make('created_at')
                    ->label('Fecha')
                    ->dateTime('d/m/Y H:i'),
            ])
            ->defaultSort('created_at', 'asc')
            ->paginated(false)
            ->headerActions([])
            ->actions([])
            ->bulkActions([]);
    }
}
