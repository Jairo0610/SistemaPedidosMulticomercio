package com.example.app_pedidos_multicomercio;

import android.content.Intent;
import android.os.Bundle;
import android.widget.FrameLayout;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.fragment.app.Fragment;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class MainActivity extends AppCompatActivity {

    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            Insets imeInsets  = insets.getInsets(WindowInsetsCompat.Type.ime());
            v.setPadding(
                    systemBars.left, systemBars.top, systemBars.right, Math.max(systemBars.bottom, imeInsets.bottom)
            );
            return insets;
        });

        mAuth = FirebaseAuth.getInstance();

        //Verificando si el usuario ya esta autentificado
        FirebaseUser currentUser = mAuth.getCurrentUser();
        if (currentUser != null){
            Intent intent = new Intent(this, SessionActivity.class);
            startActivity(intent);
        }
        else {
            cargarVista(new LoginFragment());
        }
    }

    private void cargarVista(Fragment fragment){
        getSupportFragmentManager().beginTransaction().replace(R.id.mainFrame, fragment).commit();
    }
}