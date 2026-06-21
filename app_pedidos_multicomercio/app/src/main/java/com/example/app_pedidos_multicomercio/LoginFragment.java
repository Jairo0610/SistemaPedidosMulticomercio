package com.example.app_pedidos_multicomercio;

import static android.content.ContentValues.TAG;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class LoginFragment extends Fragment {
    private FirebaseAuth mAuth;
    private EditText txtEmail, txtPass;
    private TextView btnRegister;
    private Button btnLogin;
    private SignInButton btnLoginGoogle;


    public LoginFragment() {
        // Required empty public constructor
    }


    public static LoginFragment newInstance(String param1, String param2) {
        LoginFragment fragment = new LoginFragment();
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
        View view = inflater.inflate(R.layout.fragment_login, container, false);
        txtEmail = view.findViewById(R.id.txtEmailUserLogin);
        txtPass = view.findViewById(R.id.txtPassUserLogin);
        btnLogin = view.findViewById(R.id.btnLoginUser);
        btnRegister = view.findViewById(R.id.btnViewRegister);
        btnLoginGoogle = view.findViewById(R.id.btnLoginGoogle);

        mAuth = FirebaseAuth.getInstance();

        btnLogin.setOnClickListener(v -> {

            String email = txtEmail.getText().toString(),
                    pass = txtPass.getText().toString();

            if (!email.isEmpty() && !pass.isEmpty()){
                mAuth.signInWithEmailAndPassword(email, pass).addOnCompleteListener(requireActivity(), new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            // Sign in success, update UI with the signed-in user's information
                            Log.d(TAG, "signInWithEmail:success");
                            FirebaseUser user = mAuth.getCurrentUser();
                            updateUI(user);
                        } else {
                            // If sign in fails, display a message to the user.
                            Log.w(TAG, "signInWithEmail:failure", task.getException());
                            Toast.makeText(getContext(), "Authentication failed.",
                                    Toast.LENGTH_SHORT).show();
                            updateUI(null);
                        }
                    }
                });
            }
        });

        btnRegister.setOnClickListener(v -> getParentFragmentManager().
                beginTransaction().replace(R.id.mainFrame, new RegisterFragment()).commit());

        btnLoginGoogle.setOnClickListener(v -> {

        });

        return view;
    }
    private void updateUI(FirebaseUser user) {
        if (user != null) {
            // Usuario registrado exitosamente
            Toast.makeText(getContext(), "Inicio de sesión exitoso!", Toast.LENGTH_SHORT).show();

            Intent intent = new Intent(requireContext(),  SessionActivity.class);
            startActivity(intent);
        } else {
            // Inicio fallido, limpiar campos
            txtEmail.setText("");
            txtPass.setText("");
        }
    }
}