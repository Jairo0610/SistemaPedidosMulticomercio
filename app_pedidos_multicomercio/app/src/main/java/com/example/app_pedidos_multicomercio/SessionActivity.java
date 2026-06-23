package com.example.app_pedidos_multicomercio;

import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.fragment.app.Fragment;

import com.example.app_pedidos_multicomercio.DataBase.AppDataBase;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class SessionActivity extends AppCompatActivity {
    private FirebaseAuth mAuth;
    private FirebaseUser userSession;
    private AppDataBase db_conn;
    private BottomNavigationView navigationView;

    @Override
    protected void onStart() {
        super.onStart();
    }

    private void cargarFragment (Fragment fragment){
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.sessionFrame, fragment).commit();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_session);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        getOnBackPressedDispatcher().addCallback(this,
                new androidx.activity.OnBackPressedCallback(true) {
                    @Override
                    public void handleOnBackPressed() {
                        finishAffinity();
                    }
                }
        );

        mAuth = FirebaseAuth.getInstance();


        //db_conn = AppDataBase.getInstance(getApplicationContext());

        navigationView = findViewById(R.id.navegationSession);

        cargarFragment(new InicioFragment());

        navigationView.setOnItemSelectedListener(menuItem -> {
            if (menuItem.getItemId() == R.id.btnInicioSession){

                cargarFragment(new InicioFragment());
                return true;

            } else if (menuItem.getItemId() == R.id.btnCarritoSession) {

                cargarFragment(new CarritoFragment());
                return true;

            } else if (menuItem.getItemId() == R.id.btnPedidosSession) {

                cargarFragment(new PedidosFragment());
                return true;

            } else if (menuItem.getItemId() == R.id.btnPerfilSession) {

                cargarFragment(new PerfilFragment());
                return true;

            }

            return false;
        });
    }
}