package com.example.app_pedidos_multicomercio;

import static android.content.ContentValues.TAG;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;


public class RegisterFragment extends Fragment {

    private FirebaseAuth mAuth;
    private TextView btnInicioSesion;
    private Button btnRegister;
    private EditText txtEmail, txtPass;


    public RegisterFragment() {
        // Required empty public constructor
    }


    public static RegisterFragment newInstance() {
        RegisterFragment fragment = new RegisterFragment();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_register, container, false);

        mAuth = FirebaseAuth.getInstance();

        btnInicioSesion = view.findViewById(R.id.btnViewLogin);
        btnRegister = view.findViewById(R.id.btnUserRegister);
        txtEmail = view.findViewById(R.id.txtEmailUserRegister);
        txtPass = view.findViewById(R.id.txtPassUserRegister);

        btnRegister.setOnClickListener(v -> {
            String email = txtEmail.getText().toString();
            String pass = txtPass.getText().toString();

            if (!email.isEmpty() && !pass.isEmpty()){

                mAuth.createUserWithEmailAndPassword(email, pass).addOnCompleteListener(requireActivity(), new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            // Sign in success, update UI with the signed-in user's information
                            Log.d(TAG, "createUserWithEmail:success");
                            FirebaseUser user = mAuth.getCurrentUser();
                            updateUI(user);
                        } else {
                            // Muestra el error exacto de Firebase
                            String errorMsg = task.getException() != null
                                    ? task.getException().getMessage()
                                    : "Error desconocido";

                            Log.w(TAG, "createUserWithEmail:failure", task.getException());
                            Toast.makeText(getContext(), errorMsg, Toast.LENGTH_LONG).show();
                            updateUI(null);
                        }
                    }
                });
            }
        });

        btnInicioSesion.setOnClickListener(v -> {
            getParentFragmentManager().beginTransaction().replace(R.id.mainFrame, new LoginFragment()).commit();
        });

        return view;
    }
    private void updateUI(FirebaseUser user) {
        if (user != null) {
            // Usuario registrado exitosamente
            Toast.makeText(getContext(), "Registro exitoso: " + user.getEmail(), Toast.LENGTH_SHORT).show();

            // Navegar al LoginFragment (o al fragment principal)
            getParentFragmentManager()
                    .beginTransaction()
                    .replace(R.id.mainFrame, new LoginFragment())
                    .commit();
        } else {
            // Registro fallido, limpiar campos
            txtEmail.setText("");
            txtPass.setText("");
        }
    }
}