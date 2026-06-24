<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StorePedidoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'empresa_id'           => ['required', 'integer', 'exists:empresas,id'],
            // La dirección debe existir y pertenecer al usuario autenticado.
            'direccion_id'         => [
                'required',
                'integer',
                Rule::exists('direcciones', 'id')->where('user_id', $this->user()->id),
            ],
            'items'                => ['required', 'array', 'min:1'],
            'items.*.producto_id'  => ['required', 'integer', 'exists:productos,id'],
            'items.*.cantidad'     => ['required', 'integer', 'min:1'],
        ];
    }
}
