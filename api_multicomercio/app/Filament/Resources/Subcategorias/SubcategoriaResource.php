<?php

namespace App\Filament\Resources\Subcategorias;

use App\Filament\Resources\Subcategorias\Pages\CreateSubcategoria;
use App\Filament\Resources\Subcategorias\Pages\EditSubcategoria;
use App\Filament\Resources\Subcategorias\Pages\ListSubcategorias;
use App\Filament\Resources\Subcategorias\Schemas\SubcategoriaForm;
use App\Filament\Resources\Subcategorias\Tables\SubcategoriasTable;
use App\Models\Subcategoria;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class SubcategoriaResource extends Resource
{
    protected static ?string $model = Subcategoria::class;

    protected static ?string $modelLabel = 'Subcategoría';
    protected static ?string $pluralModelLabel = 'Subcategorías';
    protected static ?string $navigationLabel = 'Subcategorías';
    protected static string|\UnitEnum|null $navigationGroup = 'Catálogo';
    protected static ?int $navigationSort = 2;
    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-list-bullet';

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
        return SubcategoriaForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return SubcategoriasTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index'  => ListSubcategorias::route('/'),
            'create' => CreateSubcategoria::route('/create'),
            'edit'   => EditSubcategoria::route('/{record}/edit'),
        ];
    }
}
