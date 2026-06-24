package com.example.app_pedidos_multicomercio;

import static android.content.ContentValues.TAG;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.fragment.app.Fragment;

import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.tasks.Task;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.auth.AuthCredential;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthUserCollisionException;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GoogleAuthProvider;

import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.Models.AuthRequest;
import com.example.app_pedidos_multicomercio.Models.AuthResponse;
import com.example.app_pedidos_multicomercio.Util.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class LoginFragment extends Fragment {

    private static final int RC_SIGN_IN = 100;
    private FirebaseAuth mAuth;
    private GoogleSignInClient googleSignInClient;
    private TextInputEditText txtEmail, txtPass;
    private TextView btnRegister;
    private Button btnLogin;
    private SignInButton btnLoginGoogle;

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

        // Configurar Google Sign-In
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(getString(R.string.default_web_client_id))
                .requestEmail()
                .build();
        googleSignInClient = GoogleSignIn.getClient(requireActivity(), gso);

        // Login con email/contraseña
        btnLogin.setOnClickListener(v -> {
            String email = txtEmail.getText().toString();
            String pass  = txtPass.getText().toString();

            if (!email.isEmpty() && !pass.isEmpty()) {

                mAuth.signInWithEmailAndPassword(email, pass)
                        .addOnCompleteListener(requireActivity(), task -> {
                            if (task.isSuccessful()) {
                                updateUI(mAuth.getCurrentUser());
                            } else {
                                Toast.makeText(getContext(),
                                        "Credenciales incorrectas", Toast.LENGTH_SHORT).show();
                                updateUI(null);
                            }
                        });
            } else {
                Toast.makeText(getContext(),
                        "Completa todos los campos", Toast.LENGTH_SHORT).show();
            }
        });

        // Ir a registro
        btnRegister.setOnClickListener(v -> getParentFragmentManager()
                .beginTransaction()
                .replace(R.id.mainFrame, new RegisterFragment())
                .commit());

        // Login con Google
        btnLoginGoogle.setOnClickListener(v -> {
            Log.d(TAG, "Client ID: " + getString(R.string.default_web_client_id));
            Intent signInIntent = googleSignInClient.getSignInIntent();
            startActivityForResult(signInIntent, RC_SIGN_IN);
        });

        return view;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RC_SIGN_IN) {
            Task<GoogleSignInAccount> task =
                    GoogleSignIn.getSignedInAccountFromIntent(data);
            try {
                GoogleSignInAccount account = task.getResult(ApiException.class);
                firebaseAuthWithGoogle(account.getIdToken());
            } catch (ApiException e) {
                Toast.makeText(getContext(),
                        "Error Google: " + e.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void firebaseAuthWithGoogle(String idToken) {
        AuthCredential googleCredential = GoogleAuthProvider.getCredential(idToken, null);

        mAuth.signInWithCredential(googleCredential)
                .addOnCompleteListener(requireActivity(), task -> {
                    if (task.isSuccessful()) {
                        updateUI(mAuth.getCurrentUser());
                    } else if (task.getException() instanceof FirebaseAuthUserCollisionException) {

                        // El email ya existe con email/password
                        // Obtenemos el email desde la cuenta de Google
                        FirebaseAuthUserCollisionException collision =
                                (FirebaseAuthUserCollisionException) task.getException();
                        String emailEnConflicto = collision.getEmail();

                        // Buscar con qué proveedor está registrado ese email
                        mAuth.fetchSignInMethodsForEmail(emailEnConflicto)
                                .addOnCompleteListener(fetchTask -> {
                                    if (fetchTask.isSuccessful()) {
                                        java.util.List<String> metodos =
                                                fetchTask.getResult().getSignInMethods();

                                        if (metodos != null && metodos.contains("password")) {
                                            // Está registrado con email/pass
                                            // Pedimos la contraseña al usuario para vincular
                                            pedirContrasenaParaVincular(emailEnConflicto, googleCredential);
                                        }
                                    }
                                });
                    } else {
                        Log.w(TAG, "signInWithCredential:failure", task.getException());
                        Toast.makeText(getContext(),
                                "Autenticación fallida", Toast.LENGTH_SHORT).show();
                    }
                });
    }

    private void pedirContrasenaParaVincular(String email, AuthCredential googleCredential) {
        // Mostramos un dialogo pidiendo la contraseña
        android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(requireContext());
        builder.setTitle("Vincular cuenta");
        builder.setMessage("El correo " + email + " ya está registrado.\nIngresa tu contraseña para vincular tu cuenta de Google.");

        android.widget.EditText inputPass = new android.widget.EditText(requireContext());
        inputPass.setInputType(android.text.InputType.TYPE_CLASS_TEXT |
                android.text.InputType.TYPE_TEXT_VARIATION_PASSWORD);
        inputPass.setHint("Contraseña");
        builder.setView(inputPass);

        builder.setPositiveButton("Vincular", (dialog, which) -> {
            String password = inputPass.getText().toString().trim();
            if (!password.isEmpty()) {
                // Iniciar sesión con email/pass y luego vincular Google
                mAuth.signInWithEmailAndPassword(email, password)
                        .addOnCompleteListener(requireActivity(), loginTask -> {
                            if (loginTask.isSuccessful()) {
                                // Vincular Google a la cuenta existente
                                mAuth.getCurrentUser()
                                        .linkWithCredential(googleCredential)
                                        .addOnCompleteListener(linkTask -> {
                                            if (linkTask.isSuccessful()) {
                                                Toast.makeText(getContext(),
                                                        "¡Cuentas vinculadas! Ahora puedes usar ambos métodos.",
                                                        Toast.LENGTH_SHORT).show();
                                            }
                                            // Navegar igual aunque falle el link
                                            updateUI(mAuth.getCurrentUser());
                                        });
                            } else {
                                Toast.makeText(getContext(),
                                        "Contraseña incorrecta", Toast.LENGTH_SHORT).show();
                            }
                        });
            }
        });

        builder.setNegativeButton("Cancelar", (dialog, which) -> dialog.dismiss());
        builder.show();
    }

    private void updateUI(FirebaseUser user) {
        if (user != null) {
            // El login de Firebase fue correcto. Antes de entrar, canjeamos su ID token
            // por un token de Sanctum del backend (es el que autoriza las peticiones).
            canjearTokenYEntrar(user);
        } else {
            txtEmail.setText("");
            txtPass.setText("");
        }
    }

    /**
     * Pide el ID token a Firebase, lo envía a POST /api/auth/firebase y, si el backend
     * responde con un token de Sanctum, lo guarda y abre la sesión.
     */
    private void canjearTokenYEntrar(FirebaseUser user) {
        String nombre = user.getDisplayName() != null ? user.getDisplayName() : user.getEmail();

        user.getIdToken(true).addOnCompleteListener(tokenTask -> {
            if (!tokenTask.isSuccessful() || tokenTask.getResult().getToken() == null) {
                Toast.makeText(getContext(), "No se pudo obtener el token de Firebase", Toast.LENGTH_SHORT).show();
                return;
            }

            String idToken = tokenTask.getResult().getToken();

            ApiClient.getApiService().authFirebase(new AuthRequest(idToken))
                    .enqueue(new Callback<AuthResponse>() {
                        @Override
                        public void onResponse(Call<AuthResponse> call, Response<AuthResponse> response) {
                            if (!isAdded()) return;

                            if (response.isSuccessful() && response.body() != null) {
                                SessionManager.guardarToken(requireContext(), response.body().getToken());

                                Toast.makeText(getContext(),
                                        "¡Bienvenido " + nombre + "!", Toast.LENGTH_SHORT).show();

                                Intent intent = new Intent(requireActivity(), SessionActivity.class);
                                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
                                startActivity(intent);
                            } else {
                                Toast.makeText(getContext(),
                                        "El servidor rechazó el inicio de sesión (" + response.code() + ")",
                                        Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onFailure(Call<AuthResponse> call, Throwable t) {
                            if (!isAdded()) return;
                            Toast.makeText(getContext(),
                                    "Error de red al iniciar sesión: " + t.getMessage(),
                                    Toast.LENGTH_SHORT).show();
                        }
                    });
        });
    }
}