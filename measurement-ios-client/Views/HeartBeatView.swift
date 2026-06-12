import UIKit

class HeartBeatView: UIView {
    private var heartRateLabel: UILabel!
    private var heartImageView: UIImageView!
    
    // 公开属性，用于更新心跳数
    var heartRate: String = "--" {
        didSet {
            guard heartRateLabel != nil else { return } // 避免初始化前更新
            heartRateLabel.text = heartRate
        }
    }

    // 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // 设置心形图片（建议添加默认图防止图片不存在）
        let heartImage = UIImage(named: "measure_heart") ?? UIImage(systemName: "heart.fill")
        heartImageView = UIImageView(image: heartImage)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.contentMode = .scaleAspectFit
        addSubview(heartImageView)

        // 设置心跳数标签
        heartRateLabel = UILabel()
        heartRateLabel.translatesAutoresizingMaskIntoConstraints = false
        heartRateLabel.text = heartRate
        heartRateLabel.textColor = .white
        heartRateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(heartRateLabel)

        // 约束设置
        NSLayoutConstraint.activate([
            heartImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heartImageView.widthAnchor.constraint(equalToConstant: 70),
            heartImageView.heightAnchor.constraint(equalToConstant: 70),

            heartRateLabel.centerXAnchor.constraint(equalTo: heartImageView.centerXAnchor),
            heartRateLabel.centerYAnchor.constraint(equalTo: heartImageView.centerYAnchor)
        ])

        // 确保UI布局完成后启动动画
        DispatchQueue.main.async { [weak self] in
            self?.startHeartBeatAnimation()
        }
    }

    private func startHeartBeatAnimation() {
        // 先重置transform和透明度，避免动画叠加异常
        heartImageView.transform = .identity
        heartImageView.alpha = 0.8 // 初始透明度
        
        // 心跳动画：先快速放大（伴随透明度提升），再缓慢缩小（伴随透明度降低），循环执行
        UIView.animate(withDuration: 0.2,          // 快速放大
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
            guard let self = self else { return }
            // 缩小放大幅度（1.1倍，可根据需求调整为1.05/1.15等）
            self.heartImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.heartImageView.alpha = 1.0 // 放大时完全不透明
        }) { [weak self] _ in
            // 放大完成后，缓慢缩小（自动反转+循环，伴随透明度渐变）
            UIView.animate(withDuration: 0.6,
                           delay: 0,
                           options: [.autoreverse, .repeat, .curveEaseInOut],
                           animations: { [weak self] in
                guard let self = self else { return }
                self.heartImageView.transform = .identity
                self.heartImageView.alpha = 0.8 // 缩小时略透明
            })
        }
    }

    // 更新心跳数（保留兼容接口）
    func updateHeartRate(to newHeartRate: String) {
        heartRate = newHeartRate // 复用didSet逻辑，保证一致性
    }
}
