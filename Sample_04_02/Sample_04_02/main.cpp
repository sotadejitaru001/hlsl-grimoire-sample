#include "stdafx.h"
#include "system/system.h"

// step-1 ディレクションライト用の構造体を定義する
struct DirectionLight
{
    Vector3 ligDirection;//ライト方向

    float pad;//バディング

    Vector3 ligColor;//ライトカラー
};
///////////////////////////////////////////////////////////////////
// ウィンドウプログラムのメイン関数
///////////////////////////////////////////////////////////////////
int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPWSTR lpCmdLine, int nCmdShow)
{
    // ゲームの初期化
    InitGame(hInstance, hPrevInstance, lpCmdLine, nCmdShow, TEXT("Game"));

    //////////////////////////////////////
    // ここから初期化を行うコードを記述する
    //////////////////////////////////////

    g_camera3D->SetPosition({ 0.0f, 0.0f, 100.0f });
    g_camera3D->SetTarget({ 0.0f, 0.0f, 0.0f });

    // step-2 ディレクションライトのデータを作成する
    DirectionLight directionLig;

    directionLig.ligDirection.x = 1.0f;
    directionLig.ligDirection.y = -1.0f;
    directionLig.ligDirection.z = -1.0f;

    directionLig.ligColor.Normalize();

    directionLig.ligColor.x = 0.5f;
    directionLig.ligColor.y = 0.5f;
    directionLig.ligColor.z = 0.5f;

    // step-3 球体モデルを初期化する
    ModelInitData modelInitDate;
    modelInitDate.m_tkmFilePath = "Assets/modelData/teapot.tkm";

    modelInitDate.m_fxFilePath = "Assets/shader/sample.fx";

    modelInitDate.m_expandConstantBuffer = &directionLig;
    modelInitDate.m_expandConstantBufferSize = sizeof(directionLig);

    Model model;
    model.Init(modelInitDate);

    //////////////////////////////////////
    // 初期化を行うコードを書くのはここまで！！！
    //////////////////////////////////////
    auto& renderContext = g_graphicsEngine->GetRenderContext();

    // ここからゲームループ
    while (DispatchWindowMessage())
    {
        // レンダリング開始
        g_engine->BeginFrame();
        //////////////////////////////////////
        // ここから絵を描くコードを記述する
        //////////////////////////////////////

        // step-4 モデルをドローする
        model.Draw(renderContext);
        //////////////////////////////////////
        // 絵を描くコードを書くのはここまで！！！
        //////////////////////////////////////
        // レンダリング終了
        g_engine->EndFrame();
    }
    return 0;
}
