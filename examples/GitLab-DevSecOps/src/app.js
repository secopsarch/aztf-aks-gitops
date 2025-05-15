// Simple JavaScript for the demo application
document.addEventListener('DOMContentLoaded', function() {
    const features = document.querySelectorAll('.features li');
    
    features.forEach((feature, index) => {
        setTimeout(() => {
            feature.style.opacity = '0';
            feature.style.transition = 'opacity 0.5s ease-in';
            feature.style.opacity = '1';
        }, index * 200);
    });
});
