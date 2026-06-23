<?php

namespace App\Filament\Resources\Disponibilidads;

use App\Filament\Resources\Disponibilidads\Pages\CreateDisponibilidad;
use App\Filament\Resources\Disponibilidads\Pages\EditDisponibilidad;
use App\Filament\Resources\Disponibilidads\Pages\ListDisponibilidads;
use App\Filament\Resources\Disponibilidads\Schemas\DisponibilidadForm;
use App\Filament\Resources\Disponibilidads\Tables\DisponibilidadsTable;
use App\Models\Disponibilidad;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class DisponibilidadResource extends Resource
{
    protected static ?string $model = Disponibilidad::class;

    protected static ?string $modelLabel = 'Disponibilidad';
    protected static ?string $pluralModelLabel = 'Disponibilidades';
    protected static ?string $navigationLabel = 'Disponibilidades';
    protected static string|\UnitEnum|null $navigationGroup = 'Empresas';
    protected static ?int $navigationSort = 3;
    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-clipboard-document-list';

    // Filtra por sucursales de la empresa del usuario autenticado
    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery();

        if (auth()->user()?->rol === 'empresa') {
            $empresaId = auth()->user()->empresa?->id;
            if ($empresaId) {
                $query->whereHas('sucursal', fn (Builder $q) => $q->where('empresa_id', $empresaId));
            }
        }

        return $query;
    }

    public static function form(Schema $schema): Schema
    {
        return DisponibilidadForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return DisponibilidadsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index'  => ListDisponibilidads::route('/'),
            'create' => CreateDisponibilidad::route('/create'),
            'edit'   => EditDisponibilidad::route('/{record}/edit'),
        ];
    }
}
