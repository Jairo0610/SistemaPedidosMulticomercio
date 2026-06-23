package com.example.app_pedidos_multicomercio;

import static android.content.ContentValues.TAG;

import android.Manifest;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.PickVisualMediaRequest;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.core.content.FileProvider;
import androidx.fragment.app.Fragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.datepicker.MaterialDatePicker;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


public class RegisterFragment extends Fragment {

    private FirebaseAuth mAuth;
    private TextView btnInicioSesion;
    private Button btnRegister;
    private FloatingActionButton btnTomarFoto, btnElegirFoto;
    private ImageView imgPerfil;
    private TextInputEditText txtNombre, txtEmail,
            txtFechaNacimiento , txtClave, txtConfirmarClave;

    private Uri uriImageCamara;
    private Uri uriFotoSeleccionada = null;
    private String rutaCamara;

    private final ActivityResultLauncher<PickVisualMediaRequest> selecionarImagen =
            registerForActivityResult(new ActivityResultContracts.PickVisualMedia(), uri -> {
                if (uri == null) return;
                String newRoute = copiarImagenApp(uri);
                if (newRoute != null) {
                    imgPerfil.setImageURI(Uri.fromFile(new File(newRoute)));
                }
            });

    private final ActivityResultLauncher<String> solicitarPermisoGaleria =
            registerForActivityResult(new ActivityResultContracts.RequestPermission(), resultado -> {
                if (resultado) {
                    abrirGaleria();
                }
            });
    private final ActivityResultLauncher<Uri> seleccionaImagenCamara =
            registerForActivityResult(new ActivityResultContracts.TakePicture(), resultado -> {
                if (resultado && uriImageCamara != null) {
                    uriFotoSeleccionada = uriImageCamara;
                    imgPerfil.setImageURI(uriImageCamara);
                }
            });

    private final ActivityResultLauncher<String> seleccionaImagenCamara2 =
            registerForActivityResult(new ActivityResultContracts.RequestPermission(), resultado -> {
                if (resultado) {
                    abrirCamara();
                }
            });

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

        imgPerfil = view.findViewById(R.id.imgPerfilRegister);
        imgPerfil.setImageResource(R.drawable.img_perfil_default);

        btnInicioSesion = view.findViewById(R.id.btnViewLogin);
        btnRegister = view.findViewById(R.id.btnUserRegister);
        btnTomarFoto = view.findViewById(R.id.btnTomarFotoRegistrar);
        btnElegirFoto = view.findViewById(R.id.btnElgirFotoRegistrar);

        txtNombre = view.findViewById(R.id.txtNombreRegistrar);
        txtFechaNacimiento = view.findViewById(R.id.txtFechaNacimientoRegistrar);
        txtEmail = view.findViewById(R.id.txtEmailRegistrar);
        txtClave = view.findViewById(R.id.txtClaveRegistrar);
        txtConfirmarClave = view.findViewById(R.id.txtConfirmarClaveRegistrar);

        btnTomarFoto.setOnClickListener(v -> validarPermisoCamara());

        btnElegirFoto.setOnClickListener(v -> validarPermisoGaleria());

        txtFechaNacimiento.setOnClickListener(v -> {
            MaterialDatePicker<Long> datePicker = MaterialDatePicker.Builder.datePicker()
                    .setTitleText("Selecciona tu fecha de nacimiento")
                    .build();

            datePicker.show(getParentFragmentManager(), "DATE_PICKER");

            datePicker.addOnPositiveButtonClickListener(selection -> {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
                txtFechaNacimiento.setText(sdf.format(new Date(selection)));
            });
        });

        btnRegister.setOnClickListener(v -> {
            String email = txtEmail.getText().toString();
            String pass = txtClave.getText().toString();

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
            txtClave.setText("");
        }
    }

    private void abrirGaleria(){
        selecionarImagen.launch(new PickVisualMediaRequest.Builder()
                .setMediaType(ActivityResultContracts.PickVisualMedia.ImageOnly.INSTANCE)
                .build());
    }

    private String copiarImagenApp(Uri uriOriginal) {
        try {

            InputStream inputStream =
                    requireActivity().getContentResolver().openInputStream(uriOriginal);

            String nombreArchivo =
                    "IMG_" + System.currentTimeMillis() + ".jpg";

            File directorio =
                    new File(requireActivity().getFilesDir(), "imagenes");

            if (!directorio.exists()) {
                directorio.mkdirs();
            }

            File archivoDestino =
                    new File(directorio, nombreArchivo);

            OutputStream outputStream =
                    new FileOutputStream(archivoDestino);

            byte[] buffer = new byte[4096];
            int bytesLeidos;

            while ((bytesLeidos = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesLeidos);
            }

            inputStream.close();
            outputStream.close();

            return archivoDestino.getAbsolutePath();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    private void abrirCamara() {
        try {
            File archivoImagen = crearArchivoImagenCamara();
            rutaCamara = archivoImagen.getAbsolutePath();
            uriImageCamara = FileProvider.getUriForFile(requireActivity(), requireActivity().getPackageName() + ".provider", archivoImagen);
            seleccionaImagenCamara.launch(uriImageCamara);
        } catch (IOException e) {
            e.printStackTrace();
            Toast.makeText(requireActivity(), "Error al crear imagen", Toast.LENGTH_SHORT).show();
        }
    }

    private File crearArchivoImagenCamara() throws IOException {
        String nombreArchivo = "CAM_" + System.currentTimeMillis() + ".jpg";
        File directorio = new File(requireActivity().getFilesDir(), "imagenes");
        if (!directorio.exists()) directorio.mkdirs();
        return new File(directorio, nombreArchivo);
    }

    private void validarPermisoCamara() {
        if (ContextCompat.checkSelfPermission(requireActivity(), Manifest.permission.CAMERA)
                == PackageManager.PERMISSION_GRANTED) {
            abrirCamara();
        } else {
            seleccionaImagenCamara2.launch(Manifest.permission.CAMERA);
        }
    }

    private void validarPermisoGaleria() {
        String permiso;

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            permiso = Manifest.permission.READ_MEDIA_IMAGES;
        } else {
            permiso = Manifest.permission.READ_EXTERNAL_STORAGE;
        }

        if (ContextCompat.checkSelfPermission(requireActivity(), permiso)
                == PackageManager.PERMISSION_GRANTED) {
            abrirGaleria();
        } else {
            solicitarPermisoGaleria.launch(permiso);
        }
    }
}