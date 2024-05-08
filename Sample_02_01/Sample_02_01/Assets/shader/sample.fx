// 頂点シェーダーへの入力頂点構造体
struct VSInput
{
	float4 pos : POSITION;
	float3 color : COLER;
};
// 頂点シェーダーの出力
	struct VSOutput
	{
		float4 pos : SV_POSITION;
		float3 color : COLOR;
	};



// 頂点シェーダー
// 1. 引数は変換前の頂点情報
// 2. 戻り値は変換後の頂点情報
	VSOutput VSMain(VSInput In)
	{
		VSOutput vsOut = (VSOutput) 0;

    // step-1 入力された頂点座標を出力データに代入する
		vsOut.pos = In.pos;
    // step-2 入力された頂点座標を2倍に拡大する
		vsOut.pos.xy *= 2.0f;
    // step-3 入力されたX座標を1.5倍、Y座標を0.5倍にして出力
		vsOut.pos.x *= 1.5f;
		vsOut.pos.y *= 0.5f;
	
		vsOut.color = In.color;
		return vsOut;
	}

// ピクセルシェーダー
	float4 PSMain(VSOutput vsOut) : SV_Target0
	{
		float4 color;
		color.x = vsOut.color.x;
		color.y = vsOut.color.y;
		color.z = vsOut.color.z;
		color.w = 1.0f;
		return color;
	}