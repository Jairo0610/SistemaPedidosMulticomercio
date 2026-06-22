<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Database\Factories\UserFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<UserFactory> */
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'firebase_uid',
        'telefono',
        'foto_url',
        'rol',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    // Solo aplica si el rol del usuario es 'empresa', un usuario gestiona una sola empresa
    public function empresa()
    {
        return $this->hasOne(Empresa::class);
    }

    // Historial de compras del cliente
    public function pedidos()
    {
        return $this->hasMany(Pedido::class);
    }

    // Lista de direcciones del cliente para entrega a domicilio
    public function direcciones()
    {
        return $this->hasMany(Direccion::class);
    }

    // Reseñas que el cliente ha dejado en productos
    public function calificaciones()
    {
        return $this->hasMany(Calificacion::class);
    }

    // Productos marcados como favoritos por el cliente
    public function favoritos()
    {
        return $this->hasMany(Favorito::class);
    }

    // Notificaciones push recibidas (cambios de estado de pedidos)
    public function notificaciones()
    {
        return $this->hasMany(Notificacion::class);
    }

    // Dispositivos registrados para envío de notificaciones FCM
    public function dispositivos()
    {
        return $this->hasMany(Dispositivo::class);
    }
}
