package com.example.app_pedidos_multicomercio;

import android.content.Intent;
import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.fragment.app.Fragment;

import com.example.app_pedidos_multicomercio.DataBase.AppDataBase;
import com.example.app_pedidos_multicomercio.Util.SessionManager;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.stripe.android.PaymentConfiguration;

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

        // Cargar el token de Sanctum guardado para que el interceptor lo use
        SessionManager.init(this);

        // Si no hay token Sanctum (sesión de Firebase anterior a este flujo, o token
        // limpiado), cerramos Firebase y mandamos al login para que el intercambio
        // ocurra de forma síncrona antes de entrar a la app.
        if (SessionManager.getToken() == null) {
            mAuth.signOut();
            Intent loginIntent = new Intent(this, MainActivity.class);
            loginIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            startActivity(loginIntent);
            finish();
            return;
        }

        // Inicializar Stripe con la clave publicable
        PaymentConfiguration.init(getApplicationContext(), getString(R.string.stripe_publishable_key));

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