<?php

namespace App\Filament\Resources\Productos\Schemas;

use App\Models\Empresa;
use App\Models\Subcategoria;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Schemas\Schema;
use Illuminate\Support\HtmlString;

class ProductoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('empresa_id')
                    ->label('Empresa')
                    ->options(function () {
                        if (auth()->user()?->rol === 'empresa') {
                            return Empresa::where('user_id', auth()->id())->pluck('nombre', 'id');
                        }
                        return Empresa::orderBy('nombre')->pluck('nombre', 'id');
                    })
                    ->required()
                    ->searchable()
                    ->live()
                    ->afterStateUpdated(fn (Set $set) => $set('subcategoria_id', null)),

                Select::make('subcategoria_id')
                    ->label('Subcategoría')
                    ->options(fn (Get $get) => Subcategoria::where('empresa_id', $get('empresa_id'))
                        ->orderBy('nombre')
                        ->pluck('nombre', 'id'))
                    ->required()
                    ->searchable()
                    ->disabled(fn (Get $get) => !$get('empresa_id')),

                TextInput::make('nombre')
                    ->required(),
                Textarea::make('descripcion')
                    ->default(null)
                    ->columnSpanFull(),
                TextInput::make('precio')
                    ->required()
                    ->numeric()
                    ->prefix('$'),
                Toggle::make('activo')
                    ->required(),

                Placeholder::make('imagen_actual')
                    ->label('Imagen actual')
                    ->content(function ($record): HtmlString|string {
                        if (!$record?->imagen_url) {
                            return 'Sin imagen';
                        }
                        $bucket = config('filesystems.disks.firebase.bucket');
                        $url = 'https://firebasestorage.googleapis.com/v0/b/'
                            . $bucket . '/o/' . rawurlencode($record->imagen_url)
                            . '?alt=media';
                        return new HtmlString(
                            '<style>.img-prod-pv{background:#fff}.dark .img-prod-pv{background:#374151}</style>'
                            . '<div class="img-prod-pv" style="display:inline-flex;border-radius:8px;padding:6px;">'
                            . '<img src="' . e($url) . '" style="height:48px;width:auto;object-fit:contain;">'
                            . '</div>'
                        );
                    })
                    ->hidden(fn ($record) => !$record?->imagen_url),

                FileUpload::make('imagen_nueva')
                    ->label('Subir nueva imagen')
                    ->image()
                    ->disk('firebase')
                    ->directory('productos')
                    ->fetchFileInformation(false),
            ]);
    }
}
