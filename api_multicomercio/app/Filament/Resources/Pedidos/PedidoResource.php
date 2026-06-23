<?php

namespace App\Filament\Resources\Pedidos;

use App\Filament\Resources\Pedidos\Pages\ListPedidos;
use App\Filament\Resources\Pedidos\Pages\ViewPedido;
use App\Filament\Resources\Pedidos\RelationManagers\DetallesRelationManager;
use App\Filament\Resources\Pedidos\RelationManagers\HistorialEstadosRelationManager;
use App\Filament\Resources\Pedidos\Schemas\PedidoSchema;
use App\Filament\Resources\Pedidos\Tables\PedidosTable;
use App\Models\Pedido;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class PedidoResource extends Resource
{
    protected static ?string $model = Pedido::class;

    protected static ?string $modelLabel = 'Pedido';
    protected static ?string $pluralModelLabel = 'Pedidos';
    protected static ?string $navigationLabel = 'Pedidos';
    protected static string|\UnitEnum|null $navigationGroup = 'Pedidos';
    protected static ?int $navigationSort = 1;
    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-shopping-cart';

    protected static ?string $recordTitleAttribute = 'numero';

    public static function canCreate(): bool
    {
        return false;
    }

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery();

        if (auth()->user()?->rol === 'empresa') {
            $empresaId = auth()->user()->empresa?->id;
            if ($empresaId) {
                $query->where('empresa_id', $empresaId);
            }
        }

        return $query;
    }

    public static function form(Schema $schema): Schema
    {
        return PedidoSchema::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PedidosTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            DetallesRelationManager::class,
            HistorialEstadosRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListPedidos::route('/'),
            'view'  => ViewPedido::route('/{record}'),
        ];
    }
}
