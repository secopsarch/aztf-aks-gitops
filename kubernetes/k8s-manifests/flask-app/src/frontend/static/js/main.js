// Add smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Add hover effect for cards
document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('mouseover', function() {
        this.style.transform = 'translateY(-10px)';
    });
    card.addEventListener('mouseout', function() {
        this.style.transform = 'translateY(0)';
    });
});

// Auto-update container info every 30 seconds
function updateContainerInfo() {
    fetch('/api/info')
        .then(response => response.json())
        .then(data => {
            document.querySelectorAll('.info-item').forEach(item => {
                const label = item.querySelector('.label').textContent.toLowerCase();
                const value = item.querySelector('.value');
                if (data[label.replace(':', '')]) {
                    value.textContent = data[label.replace(':', '')];
                }
            });
        })
        .catch(error => console.error('Error:', error));
}

setInterval(updateContainerInfo, 30000); 