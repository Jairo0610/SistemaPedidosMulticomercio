<?php

namespace App\Filament\Resources\Pedidos\Pages;

use App\Filament\Resources\Pedidos\PedidoResource;
use Filament\Actions\Action;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Resources\Pages\ViewRecord;

class ViewPedido extends ViewRecord
{
    protected static string $resource = PedidoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Action::make('cambiar_estado_entrega')
                ->label('Cambiar estado entrega')
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
                ->fillForm(fn () => ['estado_entrega' => $this->getRecord()->estado_entrega])
                ->action(function (array $data): void {
                    $this->getRecord()->cambiarEstado(
                        'estado_entrega',
                        $data['estado_entrega'],
                        $data['observacion'] ?? null,
                    );
                    $this->refreshFormData(['estado_entrega']);
                }),

            Action::make('cambiar_estado_pago')
                ->label('Cambiar estado pago')
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
                ->fillForm(fn () => ['estado_pago' => $this->getRecord()->estado_pago])
                ->action(function (array $data): void {
                    $this->getRecord()->cambiarEstado(
                        'estado_pago',
                        $data['estado_pago'],
                        $data['observacion'] ?? null,
                    );
                    $this->refreshFormData(['estado_pago']);
                }),
        ];
    }
}
