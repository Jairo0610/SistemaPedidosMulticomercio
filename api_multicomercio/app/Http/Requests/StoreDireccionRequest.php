<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreDireccionRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Cualquier cliente autenticado puede crear su propia dirección.
        return true;
    }

    public function rules(): array
    {
        return [
            'nombre'         => ['required', 'string', 'max:80'],
            'direccion'      => ['required', 'string', 'max:255'],
            'referencia'     => ['nullable', 'string', 'max:255'],
            'latitud'        => ['nullable', 'numeric', 'between:-90,90'],
            'longitud'       => ['nullable', 'numeric', 'between:-180,180'],
            'predeterminada' => ['boolean'],
        ];
    }
}
