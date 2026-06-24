package com.example.app_pedidos_multicomercio;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.example.app_pedidos_multicomercio.Util.FcmManager;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

// recibe las notificaciones push de FCM y las muestra; también registra el token cuando rota
public class MiFirebaseMessagingService extends FirebaseMessagingService {

    private static final String CANAL_ID = "pedidos";

    // Firebase llama esto al generar o rotar el token; lo registramos si hay sesión
    @Override
    public void onNewToken(@NonNull String token) {
        FcmManager.enviar(token);
    }

    // llega un push con la app en primer plano; lo armamos como notificación del sistema
    @Override
    public void onMessageReceived(@NonNull RemoteMessage message) {
        String titulo = "Pedido";
        String cuerpo = "";

        if (message.getNotification() != null) {
            if (message.getNotification().getTitle() != null) {
                titulo = message.getNotification().getTitle();
            }
            if (message.getNotification().getBody() != null) {
                cuerpo = message.getNotification().getBody();
            }
        }

        mostrarNotificacion(titulo, cuerpo);
    }

    private void mostrarNotificacion(String titulo, String cuerpo) {
        NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        // el canal es obligatorio desde Android 8
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel canal = new NotificationChannel(
                    CANAL_ID, "Pedidos", NotificationManager.IMPORTANCE_HIGH);
            canal.setDescription("Avisos del estado de tus pedidos");
            nm.createNotificationChannel(canal);
        }

        // al tocar la notificación se abre la sesión
        Intent intent = new Intent(this, SessionActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent,
                PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CANAL_ID)
                .setSmallIcon(R.drawable.ic_pedido)
                .setContentTitle(titulo)
                .setContentText(cuerpo)
                .setAutoCancel(true)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setContentIntent(pendingIntent);

        nm.notify((int) System.currentTimeMillis(), builder.build());
    }
}
