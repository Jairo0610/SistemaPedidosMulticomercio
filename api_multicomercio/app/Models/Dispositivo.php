<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Dispositivo extends Model
{
    protected $fillable = [
        'user_id',
        'fcm_token',
    ];

    // A quién le pertenece el dispositivo
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
