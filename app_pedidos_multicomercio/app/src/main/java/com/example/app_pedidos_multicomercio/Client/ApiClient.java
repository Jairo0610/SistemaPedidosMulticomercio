package com.example.app_pedidos_multicomercio.Client;

import com.example.app_pedidos_multicomercio.Service.ApiService;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiClient {
    private static final String BASE_URL = "http://10.0.2.2:8000/api/";
//    private static final String BASE_URL = "http://192.168.1.9:8000/api/";

    private static ApiService apiService;

    public static ApiService getApiService() {
        if (apiService == null) {
            // cliente OkHttp con el interceptor que añade el token Bearer en cada petición.
            OkHttpClient client = new OkHttpClient.Builder()
                    .addInterceptor(new AuthInterceptor())
                    .build();

            Retrofit retrofit = new Retrofit.Builder()
                    .baseUrl(BASE_URL)
                    .client(client)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();

            apiService = retrofit.create(ApiService.class);
        }
        return apiService;
    }
}
