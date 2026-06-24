package com.example.app_pedidos_multicomercio;

import android.content.Intent;
import android.media.Image;
import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.bitmap.RoundedCorners;
import com.example.app_pedidos_multicomercio.Util.SessionManager;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class PerfilFragment extends Fragment {

    private FirebaseAuth auth;
    private  FirebaseUser user;
    private Button btnCerrarSession;
    private TextView txtNombrePerfil, txtCorreoPerfil;
    private ImageView imgPerfil;

    public PerfilFragment() {
        // Required empty public constructor
    }

    public static PerfilFragment newInstance() {
        PerfilFragment fragment = new PerfilFragment();
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
        View view = inflater.inflate(R.layout.fragment_perfil, container, false);

        auth = FirebaseAuth.getInstance();

        user = auth.getCurrentUser();

        btnCerrarSession = view.findViewById(R.id.btnCerrarSesion);

        txtNombrePerfil = view.findViewById(R.id.txtNombrePerfil);
        txtCorreoPerfil = view.findViewById(R.id.txtCorreoPerfil);
        imgPerfil = view.findViewById(R.id.imgFotoPerfil);

        txtNombrePerfil.setText(user.getDisplayName());
        txtCorreoPerfil.setText(user.getEmail());

        Glide.with(requireActivity())
                .load(user.getPhotoUrl().toString())
                .transform(new RoundedCorners(24))
                .circleCrop()
                .placeholder(R.drawable.img_perfil_default)
                .into(imgPerfil);

        btnCerrarSession.setOnClickListener(v -> {
            SessionManager.limpiar(requireContext());

            FirebaseAuth.getInstance().signOut();

            GoogleSignInClient googleSignInClient =
                    GoogleSignIn.getClient(requireActivity(), GoogleSignInOptions.DEFAULT_SIGN_IN);

            googleSignInClient.signOut();

            Intent intent = new Intent(requireActivity(), MainActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            startActivity(intent);
            requireActivity().finish();
        });

        return view;
    }
}