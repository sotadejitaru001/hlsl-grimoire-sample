cbuffer cb : register(b0)
{
    float4x4 mvp; // MVP行列
    float4 mulColor; // 乗算カラー
};

cbuffer NagaCB : register(b1)
{
    float negaRate; // ネガポジ反転率
};

struct VSInput
{
    float4 pos : POSITION;
    float2 uv : TEXCOORD0;
};

struct PSInput
{
    float4 pos : SV_POSITION;
    float2 uv : TEXCOORD0;
};

Texture2D<float4> sceneTexture : register(t0); // シーンテクスチャ
sampler Sampler : register(s0);

PSInput VSMain(VSInput In)
{
    PSInput psIn;
    psIn.pos = mul(mvp, In.pos);
    psIn.uv = In.uv;
    return psIn;
}

float4 PSMain(PSInput In) : SV_Target0
{
    float4 color = sceneTexture.Sample(Sampler, In.uv);

    /*//モノクロ化
    float Y = 0.299f * color.r + 0.587f * color.g + 0.114f * color.b;
    color.r = Y;
    color.g = Y;
    color.b = Y;*/
    
    /*//モノクロ化の赤チャンネル
    float Y = 0.299f * color.r + 0.587f * color.g + 0.114f * color.b;
    color.r = Y;
    color.g = 0;
    color.b = 0;*/
    
    /*//ネガポジ反転
    float3 negaColor;
    negaColor.x = 1.0f - color.x;
    negaColor.y = 1.0f - color.y;
    negaColor.z = 1.0f - color.z;
    
    color.xyz = color+negaColor;*/
    
    /*//ソラリゼーション
    float3 solarizationColor;
    solarizationColor.x = pow(color.x - 0.5f, 2) * 4.0f;
    solarizationColor.y = pow(color.y - 0.5f, 2) * 4.0f;
    solarizationColor.z = pow(color.z - 0.5f, 2) * 4.0f;
    
    color.xyz = solarizationColor;*/
    
    return color;
}
