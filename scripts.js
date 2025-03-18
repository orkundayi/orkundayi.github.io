document.addEventListener('DOMContentLoaded', function() {
    const header = document.querySelector('header');
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const nav = document.querySelector('nav');
    const navLinks = document.querySelectorAll('nav ul li a');
    const portfolioFilters = document.querySelectorAll('.portfolio-filters button');
    const portfolioItems = document.querySelectorAll('.portfolio-item');
    const scrollElements = document.querySelectorAll('.service-card, .portfolio-item');
    const contactForm = document.getElementById('contactForm');
    const languageButton = document.querySelector('.language-button');
    const languageDropdown = document.querySelector('.language-dropdown');

    // Header scroll effect
    window.addEventListener('scroll', function() {
        header.classList.toggle('scrolled', window.scrollY > 50);
    });

    // Mobile menu toggle
    mobileMenuBtn.addEventListener('click', function() {
        nav.classList.toggle('active');
    });

    // Close mobile menu when a link is clicked
    navLinks.forEach(link => {
        link.addEventListener('click', () => nav.classList.remove('active'));
    });

    // Portfolio filtering
    portfolioFilters.forEach(filter => {
        filter.addEventListener('click', function() {
            portfolioFilters.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            const filterValue = this.getAttribute('data-filter');
            portfolioItems.forEach(item => {
                item.style.display = (filterValue === 'all' || item.getAttribute('data-category') === filterValue) ? 'block' : 'none';
            });
        });
    });

    // Scroll Animation
    const elementInView = (el, dividend = 1) => el.getBoundingClientRect().top <= (window.innerHeight || document.documentElement.clientHeight) / dividend;
    
    const handleScrollAnimation = () => {
        scrollElements.forEach(el => {
            el.classList.toggle('scrolled', elementInView(el, 1.25));
        });
    };

    handleScrollAnimation();
    window.addEventListener('scroll', handleScrollAnimation);

    // Portfolio item click interaction
    portfolioItems.forEach(item => {
        item.addEventListener('click', function() {
            console.log('Portfolyo item tıklandı:', this.querySelector('h3').textContent);
        });
    });

    // Contact form validation
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            let isValid = true;
            
            this.querySelectorAll('input, textarea').forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = 'red';
                } else {
                    input.style.borderColor = '#ddd';
                }
            });

            if (isValid) {
                alert('Mesajınız başarıyla gönderildi! En kısa sürede size dönüş yapacağız.');
                this.reset();
            } else {
                alert('Lütfen tüm alanları doldurun.');
            }
        });
    }

    // Language Switcher
    function toggleDropdown() {
        languageDropdown.style.display = languageDropdown.style.display === 'block' ? 'none' : 'block';
    }

    function setLanguage(lang) {
        document.querySelectorAll('[data-lang-tr], [data-lang-en]').forEach(el => {
            el.innerHTML = el.getAttribute(`data-lang-${lang}`);
        });
        document.getElementById("selected-flag").src = lang === "tr" ? "https://flagcdn.com/w40/tr.png" : "https://flagcdn.com/w40/gb.png";
        document.getElementById("selected-lang").textContent = lang === "tr" ? "Türkçe" : "English";
        languageDropdown.style.display = 'none';
    }

    languageButton.addEventListener('click', toggleDropdown);
    window.setLanguage = setLanguage;
    setLanguage('tr'); // Default language
});