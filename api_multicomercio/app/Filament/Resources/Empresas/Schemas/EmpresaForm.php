<?php

namespace App\Filament\Resources\Empresas\Schemas;

use App\Models\Categoria;
use App\Models\User;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;
use Illuminate\Support\HtmlString;

class EmpresaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                // Solo visible para admin; empresa no puede cambiar el propietario
                Select::make('user_id')
                    ->label('Usuario propietario')
                    ->options(
                        User::where('rol', 'empresa')->orderBy('name')->pluck('name', 'id')
                    )
                    ->required()
                    ->searchable()
                    ->hidden(fn () => auth()->user()?->rol === 'empresa'),
                Select::make('categoria_id')
                    ->label('Categoría')
                    ->options(Categoria::orderBy('nombre')->pluck('nombre', 'id'))
                    ->required()
                    ->searchable(),
                TextInput::make('nombre')
                    ->required(),
                Textarea::make('descripcion')
                    ->default(null)
                    ->columnSpanFull(),
                Toggle::make('activa')
                    ->required(),

                Placeholder::make('logo_actual')
                    ->label('Logo actual')
                    ->content(function ($record): HtmlString|string {
                        if (!$record?->logo_url) {
                            return 'Sin logo';
                        }
                        $bucket = config('filesystems.disks.firebase.bucket');
                        $url = 'https://firebasestorage.googleapis.com/v0/b/'
                            . $bucket . '/o/' . rawurlencode($record->logo_url)
                            . '?alt=media';
                        return new HtmlString(
                            '<style>.logo-pv{background:#fff}.dark .logo-pv{background:#374151}</style>'
                            . '<div class="logo-pv" style="display:inline-flex;border-radius:8px;padding:6px;">'
                            . '<img src="' . e($url) . '" style="height:48px;width:auto;object-fit:contain;">'
                            . '</div>'
                        );
                    })
                    ->hidden(fn ($record) => !$record?->logo_url),

                FileUpload::make('logo_nuevo')
                    ->label('Subir nuevo logo')
                    ->image()
                    ->disk('firebase')
                    ->directory('empresas')
                    ->fetchFileInformation(false),
            ]);
    }
}
