// swift-tools-version:6.2
import PackageDescription

let package = Package(
  name: "mlx-audio",
  platforms: [.macOS("15.4"), .iOS("18.4")],
  products: [
    .library(
      name: "MLXAudio",
      targets: ["MLXAudio"],
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/ml-explore/mlx-swift-lm", branch: "main"),
    .package(url: "https://github.com/ml-explore/mlx-swift", branch: "main"),
    .package(url: "https://github.com/huggingface/swift-transformers", .upToNextMinor(from: "1.1.0")),
    .package(url: "https://github.com/DePasqualeOrg/swift-tiktoken", branch: "main"),
  ],
  targets: [
    .target(
      name: "MLXAudio",
      dependencies: [
        .product(name: "MLXLMCommon", package: "mlx-swift-lm"),
        .product(name: "MLXLLM", package: "mlx-swift-lm"),
        // Explicit dependencies required for explicit module builds.
        .product(name: "MLX", package: "mlx-swift"),
        .product(name: "MLXNN", package: "mlx-swift"),
        .product(name: "MLXFast", package: "mlx-swift"),
        .product(name: "MLXRandom", package: "mlx-swift"),
        .product(name: "MLXFFT", package: "mlx-swift"),
        .product(name: "Transformers", package: "swift-transformers"),
        .product(name: "SwiftTiktoken", package: "swift-tiktoken"),
      ],
      path: "package",
      exclude: ["TTS/Kokoro", "Tests"],
      resources: [
        .process("TTS/OuteTTS/default_speaker.json"), // Default speaker profile for OuteTTS
      ],
    ),
    .testTarget(
      name: "MLXAudioTests",
      dependencies: ["MLXAudio"],
      path: "package/Tests",
    ),
  ],
)
