<?php

namespace App\Filament\Resources\Pedidos\Tables;

use App\Filament\Resources\Pedidos\PedidoResource;
use Filament\Actions\Action;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class PedidosTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('numero')
                    ->label('N°')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('user.name')
                    ->label('Cliente')
                    ->searchable(),

                TextColumn::make('empresa.nombre')
                    ->label('Empresa')
                    ->searchable(),

                TextColumn::make('sucursal.nombre')
                    ->label('Sucursal'),

                TextColumn::make('modalidad_entrega')
                    ->label('Modalidad')
                    ->badge()
                    ->color(fn (string $state) => match ($state) {
                        'domicilio' => 'info',
                        'retiro'    => 'warning',
                        default     => 'gray',
                    }),

                TextColumn::make('estado_entrega')
                    ->label('Entrega')
                    ->badge()
                    ->color(fn (string $state) => match ($state) {
                        'nuevo'             => 'gray',
                        'en_preparacion'    => 'warning',
                        'en_camino'         => 'info',
                        'listo_para_retiro' => 'info',
                        'entregado'         => 'success',
                        default             => 'gray',
                    }),

                TextColumn::make('estado_pago')
                    ->label('Pago')
                    ->badge()
                    ->color(fn (string $state) => match ($state) {
                        'pendiente' => 'warning',
                        'pagado'    => 'success',
                        default     => 'gray',
                    }),

                TextColumn::make('total')
                    ->label('Total')
                    ->money('USD')
                    ->sortable(),

                TextColumn::make('created_at')
                    ->label('Fecha')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
            ->recordUrl(fn ($record) => PedidoResource::getUrl('view', ['record' => $record]))
            ->actions([
                Action::make('cambiar_estado_entrega')
                    ->label('Estado entrega')
                    ->icon('heroicon-o-truck')
                    ->color('warning')
                    ->form([
                        Select::make('estado_entrega')
                            ->label('Nuevo estado')
                            ->options([
                                'nuevo'             => 'Nuevo',
                                'en_preparacion'    => 'En preparación',
                                'en_camino'         => 'En camino',
                                'listo_para_retiro' => 'Listo para retiro',
                                'entregado'         => 'Entregado',
                            ])
                            ->required(),
                        Textarea::make('observacion')
                            ->label('Observación (opcional)')
                            ->rows(2),
                    ])
                    ->fillForm(fn ($record) => ['estado_entrega' => $record->estado_entrega])
                    ->action(function ($record, array $data): void {
                        $record->update(['estado_entrega' => $data['estado_entrega']]);
                        $record->historialEstados()->create([
                            'estado'      => $data['estado_entrega'],
                            'observacion' => $data['observacion'] ?? null,
                        ]);
                    }),

                Action::make('cambiar_estado_pago')
                    ->label('Estado pago')
                    ->icon('heroicon-o-credit-card')
                    ->color('success')
                    ->form([
                        Select::make('estado_pago')
                            ->label('Nuevo estado')
                            ->options([
                                'pendiente' => 'Pendiente',
                                'pagado'    => 'Pagado',
                            ])
                            ->required(),
                        Textarea::make('observacion')
                            ->label('Observación (opcional)')
                            ->rows(2),
                    ])
                    ->fillForm(fn ($record) => ['estado_pago' => $record->estado_pago])
                    ->action(function ($record, array $data): void {
                        $record->update(['estado_pago' => $data['estado_pago']]);
                        $record->historialEstados()->create([
                            'estado'      => $data['estado_pago'],
                            'observacion' => $data['observacion'] ?? null,
                        ]);
                    }),
            ]);
    }
}
