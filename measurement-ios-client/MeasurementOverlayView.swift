//
//  MeasurementOverlayView.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//


import UIKit

class MeasurementOverlayView: UIView {
    /// 倒计时完成回调
    var countdownCompleted: (() -> Void)?
    var completeMeasurement: (() -> Void)?
    // MARK: - UI Elements
    private var countdownLabel: UILabel!
    private var progressView: UIProgressView!
    private var progressPercentageLabel: UILabel!
    public var scanningFrameView: UIView!
    private var scanLine: UIImageView!
    private var heartBeatView: HeartBeatView!
    private var dashedCircle: CAShapeLayer!
    private var instructionLabel: UILabel!  // 添加提示框

    // MARK: - Timer
    private var countdownTimer: Timer?
    private var progressTimer: Timer?
    private var progressElapsed: TimeInterval = 0
    private var totalSeconds: Int = 15
    private var remainingSeconds: Int = 0
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        // 1. 添加提示框
        instructionLabel = UILabel()
        instructionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        instructionLabel.textColor = .white
        instructionLabel.textAlignment = .center
        instructionLabel.text = "测量环境检测中，请稍等…"
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(instructionLabel)
        
        // 2. 大数字倒计时
        countdownLabel = UILabel()
        countdownLabel.font = .systemFont(ofSize: 64, weight: .semibold)
        countdownLabel.textColor = .white
        countdownLabel.textAlignment = .center
        countdownLabel.isHidden = true
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(countdownLabel)
        
        // dashed circle
        dashedCircle = CAShapeLayer()
        dashedCircle.strokeColor = UIColor.white.cgColor
        dashedCircle.lineWidth = 2
        dashedCircle.lineDashPattern = [4,3]
        dashedCircle.fillColor = UIColor.clear.cgColor
        countdownLabel.layer.addSublayer(dashedCircle)
        
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0
        progressView.trackTintColor = UIColor(white: 1.0, alpha: 0.2)
        progressView.tintColor = .green
        progressView.isHidden = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        
        // Add progress percentage label
        progressPercentageLabel = UILabel()
        progressPercentageLabel.font = .systemFont(ofSize: 12)
        progressPercentageLabel.textColor = .white
        progressPercentageLabel.textAlignment = .center  // 居中显示百分比
        progressPercentageLabel.isHidden = true
        progressPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressPercentageLabel)
        
        // 3. 扫描框 + 扫描线 - 改用AutoLayout替代固定Frame
        scanningFrameView = UIView()
        scanningFrameView.backgroundColor = .clear
//        scanningFrameView.layer.cornerRadius = 8
        scanningFrameView.clipsToBounds = true
        scanningFrameView.isHidden = true
        scanningFrameView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scanningFrameView)
        
        // 扫描线 - 初始隐藏，改用AutoLayout
        scanLine = UIImageView()
        scanLine.backgroundColor = .clear
        scanLine.isHidden = true
        scanLine.translatesAutoresizingMaskIntoConstraints = false
        scanLine.image = UIImage(named: "scanner")
        scanningFrameView.addSubview(scanLine)
        

        // 扫描框边角装饰
        addCorners(to: scanningFrameView, color: .green, lineWidth: 10, length: 25)
        
        // HeartBeatView
        heartBeatView = HeartBeatView()
        heartBeatView.translatesAutoresizingMaskIntoConstraints = false
        heartBeatView.isHidden = true
        addSubview(heartBeatView)
        
            
        // 统一约束（全部改用AutoLayout，避免Frame适配问题）
        NSLayoutConstraint.activate([
            // 提示框约束
            instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            instructionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: 250),
            instructionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // 倒计时标签
            countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 扫描框（固定300x400尺寸，居中）
            scanningFrameView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scanningFrameView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scanningFrameView.widthAnchor.constraint(equalToConstant: 300),
            scanningFrameView.heightAnchor.constraint(equalToConstant: 400),
            
            // 扫描线初始约束（宽度匹配扫描框，高度4，y轴初始在顶部外）
            scanLine.leadingAnchor.constraint(equalTo: scanningFrameView.leadingAnchor),
            scanLine.trailingAnchor.constraint(equalTo: scanningFrameView.trailingAnchor),
            scanLine.heightAnchor.constraint(equalToConstant: 60),
            scanLine.topAnchor.constraint(equalTo: scanningFrameView.topAnchor, constant: -4),
            
            // 进度条（在扫描框顶部）
            progressView.topAnchor.constraint(equalTo: scanningFrameView.topAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: scanningFrameView.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: scanningFrameView.trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            
            // 进度百分比标签（居中在进度条上）
            progressPercentageLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressPercentageLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progressPercentageLabel.widthAnchor.constraint(equalToConstant: 50),
            
            // 心跳视图
            heartBeatView.centerXAnchor.constraint(equalTo: centerXAnchor),
            heartBeatView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            heartBeatView.widthAnchor.constraint(equalToConstant: 150),
            heartBeatView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // MARK: - Corner Decoration
    private func addCorners(to view: UIView, color: UIColor, lineWidth: CGFloat, length: CGFloat) {
        // 延迟执行，确保view的bounds已确定
        DispatchQueue.main.async { [weak view] in
            guard let view = view else { return }
            
            func createCorner(path: UIBezierPath, start: CGPoint, mid: CGPoint, end: CGPoint) -> CAShapeLayer {
                path.move(to: start)
                path.addLine(to: mid)
                path.addLine(to: end)
                let layer = CAShapeLayer()
                layer.path = path.cgPath
                layer.strokeColor = color.cgColor
                layer.lineWidth = lineWidth
                layer.lineJoin = .round
                layer.lineCap = .butt
                layer.fillColor = UIColor.clear.cgColor
                return layer
            }
            
            let topLeft = createCorner(path: UIBezierPath(), start: CGPoint(x:0,y:length), mid: CGPoint(x:0,y:0), end: CGPoint(x:length,y:0))
            let topRight = createCorner(path: UIBezierPath(), start: CGPoint(x:view.bounds.width-length,y:0), mid: CGPoint(x:view.bounds.width,y:0), end: CGPoint(x:view.bounds.width,y:length))
            let bottomLeft = createCorner(path: UIBezierPath(), start: CGPoint(x:0,y:view.bounds.height-length), mid: CGPoint(x:0,y:view.bounds.height), end: CGPoint(x:length,y:view.bounds.height))
            let bottomRight = createCorner(path: UIBezierPath(), start: CGPoint(x:view.bounds.width-length,y:view.bounds.height), mid: CGPoint(x:view.bounds.width,y:view.bounds.height), end: CGPoint(x:view.bounds.width,y:view.bounds.height-length))
            
            [topLeft, topRight, bottomLeft, bottomRight].forEach { view.layer.addSublayer($0) }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 更新 dashed circle path 和 frame
        let radius: CGFloat = 50
        let centerPoint = CGPoint(x: countdownLabel.bounds.midX, y: countdownLabel.bounds.midY)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        dashedCircle.path = circlePath.cgPath
        dashedCircle.frame = countdownLabel.bounds
        // 更新扫描线的渐变层尺寸
        progressView.layer.cornerRadius = 4

    }
    
    // MARK: - Public Methods
    func updateInstructionText(to newText: String) {
        instructionLabel.text = newText
    }
    
    func startMeasurement(totalSeconds: Int) {
        stopMeasurement()
        self.totalSeconds = totalSeconds
        scanningFrameView.isHidden = false
                
        remainingSeconds = 3
        countdownLabel.text = "\(remainingSeconds)"
        countdownLabel.isHidden = false
        progressView.isHidden = false
        progressPercentageLabel.isHidden = true
        heartBeatView.isHidden = true
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            guard let self = self else { return }
            self.remainingSeconds -= 1
            if self.remainingSeconds > 0 {
                self.countdownLabel.text = "\(self.remainingSeconds)"
            } else {
                t.invalidate()
                self.instructionLabel.text = "测量中请保持静止"
                self.countdownLabel.isHidden = true
                self.heartBeatView.isHidden = false
                // 在倒计时结束后再启动扫描动画
                DispatchQueue.main.async {
                    self.resetScanLinePositionToTop()   // 保证从顶部开始，避免跳动
                    self.startScanLineAnimation()
                }
                self.startProgressCountdown(duration: totalSeconds)
                self.countdownCompleted?()
            }
        }
    }
    
    // 更新心跳数的方法
    func updateHeartRate(to newHeartRate: String) {
        self.heartBeatView.updateHeartRate(to: newHeartRate)
    }
    
    private func startScanLineAnimation() {
        scanLine.isHidden = false
        scanLine.layer.removeAllAnimations()

        let scanFrame = scanningFrameView.bounds
        let lineHeight = scanLine.bounds.height

        let startY = -lineHeight
        let endY = scanFrame.height

        let anim = CABasicAnimation(keyPath: "position.y")
        anim.fromValue = startY + lineHeight / 2
        anim.toValue = endY - lineHeight / 2
        anim.duration = 3.0
        anim.repeatCount = .infinity
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.isRemovedOnCompletion = true

        scanLine.layer.add(anim, forKey: "scanLineAnimation")
    }

    
    
    
    // 私有方法，用于开始进度条倒计时
    private func startProgressCountdown(duration: Int) {
        progressElapsed = 0
        progressView.progress = 0
        progressView.isHidden = false
        progressPercentageLabel.isHidden = false
        updateProgressPercentageUI(progress: 0)
        
        let interval: TimeInterval = 0.1
        progressTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] t in
            guard let self = self else { return }
            self.progressElapsed += interval
            let progress = min(self.progressElapsed / Double(duration), 1.0)
            self.progressView.setProgress(Float(progress), animated: true)
            if self.progressElapsed >= Double(duration) {
                t.invalidate()
                self.completeProgressCountdown()
            }
            self.updateProgressPercentageUI(progress: progress)
        }
    }
    
    // 完成测量
    private func completeProgressCountdown() {
        // 隐藏进度条和百分比标签
        progressView.isHidden = true
        progressPercentageLabel.isHidden = true
        
        // 隐藏心跳显示容器
        heartBeatView.isHidden = true
        
        // 停止扫描线动画
        stopScanLineAnimation()
        
        // 隐藏扫描框
        scanningFrameView.isHidden = true
        self.completeMeasurement?()
    }
    
    // 停止扫描线动画（增强版：彻底清理动画状态）
    private func stopScanLineAnimation() {
        scanLine.layer.removeAllAnimations()
        scanLine.isHidden = true
    }
    
    private func resetScanLinePositionToTop() {
        // 扫描线回到顶部但不触发布局闪烁
        scanLine.layer.removeAllAnimations()
        scanLine.transform = .identity
        scanLine.frame.origin.y = -4
    }

    // 停止测量
    func stopMeasurement() {
        // 停止倒计时计时器
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        // 停止进度计时器
        progressTimer?.invalidate()
        progressTimer = nil
        
        // 隐藏进度条
        progressView.isHidden = true
        progressPercentageLabel.isHidden = true
        
        // 隐藏倒计时标签
        countdownLabel.isHidden = true
        
        // 隐藏心跳视图
        heartBeatView.isHidden = true
        
        // 停止扫描线动画
        stopScanLineAnimation()
        
        // 隐藏扫描框
        scanningFrameView.isHidden = true
    }
    
    // 更新进度百分比标签
    private func updateProgressPercentageUI(progress: Double) {
        let percentage = Int(progress * 100)
        progressPercentageLabel.text = "\(percentage)%"
    }
    
    func updateTips(tip: String) {
        instructionLabel.text = tip
    }
}
