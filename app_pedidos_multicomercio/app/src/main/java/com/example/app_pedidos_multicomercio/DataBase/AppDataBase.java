package com.example.app_pedidos_multicomercio.DataBase;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.example.app_pedidos_multicomercio.DAOS.productoDAO;
import com.example.app_pedidos_multicomercio.Entitys.Producto;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Database(entities = Producto.class, version = 1, exportSchema = true)
public abstract class AppDataBase extends RoomDatabase {
    public abstract productoDAO producto_dao();

    private static volatile AppDataBase INSTANCE;

    public static final ExecutorService databaseWriteExecutor = Executors.newFixedThreadPool(2);

    public static AppDataBase getInstance(Context context){
        if (INSTANCE == null){
            synchronized (AppDataBase.class){
                if (INSTANCE == null){
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), AppDataBase.class, "db_carrito").build();

                }
            }
        }

        return INSTANCE;
    }
}
