document.addEventListener('DOMContentLoaded', function() {
    const header = document.querySelector('header');
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const nav = document.querySelector('nav');
    const navLinks = document.querySelectorAll('nav ul li a');

    // Header scroll effect
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Mobile menu toggle
    mobileMenuBtn.addEventListener('click', function() {
        nav.classList.toggle('active');
    });

    // Close mobile menu when a link is clicked
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            nav.classList.remove('active');
        });
    });

    // Portfolio filtering
    const portfolioFilters = document.querySelectorAll('.portfolio-filters button');
    const portfolioItems = document.querySelectorAll('.portfolio-item');

    portfolioFilters.forEach(filter => {
        filter.addEventListener('click', function() {
            portfolioFilters.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            const filterValue = this.getAttribute('data-filter');
            portfolioItems.forEach(item => {
                if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });

    // Scroll Animation
    const scrollElements = document.querySelectorAll('.service-card, .portfolio-item');

    const elementInView = (el, dividend = 1) => {
        const elementTop = el.getBoundingClientRect().top;
        return (
            elementTop <= 
            (window.innerHeight || document.documentElement.clientHeight) / dividend
        );
    };

    const displayScrollElement = (element) => {
        element.classList.add('scrolled');
    };

    const hideScrollElement = (element) => {
        element.classList.remove('scrolled');
    };

    const handleScrollAnimation = () => {
        scrollElements.forEach((el) => {
            if (elementInView(el, 1.25)) {
                displayScrollElement(el);
            } else {
                hideScrollElement(el);
            }
        });
    };

    // İlk yükleme için animasyonu kontrol et
    handleScrollAnimation();

    // Kaydırma olayı için animasyonu kontrol et
    window.addEventListener('scroll', () => {
        handleScrollAnimation();
    });

    // Tıklanabilir portfolio itemları için gelişmiş interaksiyon
    portfolioItems.forEach(item => {
        item.addEventListener('click', function() {
            // Burada portfolyo detay sayfasına yönlendirme yapabilirsiniz
            // Örnek: window.location.href = 'proje-detay.html?id=' + this.getAttribute('data-id');
            console.log('Portfolyo item tıklandı:', this.querySelector('h3').textContent);
        });
    });

    // Form submission için temel doğrulama
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Basit form doğrulama
            let isValid = true;
            const formInputs = this.querySelectorAll('input, textarea');
            
            formInputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = 'red';
                } else {
                    input.style.borderColor = '#ddd';
                }
            });
            
            if (isValid) {
                // Form gönderildiğinde kullanıcıya geri bildirim
                alert('Mesajınız başarıyla gönderildi! En kısa sürede size dönüş yapacağız.');
                this.reset();
            } else {
                alert('Lütfen tüm alanları doldurun.');
            }
        });
    }
});