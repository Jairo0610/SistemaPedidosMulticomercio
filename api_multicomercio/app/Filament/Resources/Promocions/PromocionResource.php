<?php

namespace App\Filament\Resources\Promocions;

use App\Filament\Resources\Promocions\Pages\CreatePromocion;
use App\Filament\Resources\Promocions\Pages\EditPromocion;
use App\Filament\Resources\Promocions\Pages\ListPromocions;
use App\Filament\Resources\Promocions\Schemas\PromocionForm;
use App\Filament\Resources\Promocions\Tables\PromocionsTable;
use App\Models\Promocion;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class PromocionResource extends Resource
{
    protected static ?string $model = Promocion::class;

    protected static ?string $modelLabel = 'Promoción';
    protected static ?string $pluralModelLabel = 'Promociones';
    protected static ?string $navigationLabel = 'Promociones';
    protected static string|\UnitEnum|null $navigationGroup = 'Promociones';
    protected static ?int $navigationSort = 1;
    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-tag';

    protected static ?string $recordTitleAttribute = 'nombre';

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
        return PromocionForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PromocionsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index'  => ListPromocions::route('/'),
            'create' => CreatePromocion::route('/create'),
            'edit'   => EditPromocion::route('/{record}/edit'),
        ];
    }
}
