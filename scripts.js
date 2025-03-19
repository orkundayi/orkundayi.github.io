document.addEventListener('DOMContentLoaded', function() {
    // This is a small change to trigger GitHub Pages rebuild
    const savedTheme = localStorage.getItem('theme');
    const darkIcon = document.getElementById('dark-icon');
    const lightIcon = document.getElementById('light-icon');
        
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-mode');
        darkIcon.style.display = 'none';
        lightIcon.style.display = 'block';
    }
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

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        if (!nav.contains(event.target) && !mobileMenuBtn.contains(event.target)) {
            nav.classList.remove('active');
        }
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

    // Language Switcher
    function toggleDropdown() {
        languageDropdown.style.display = languageDropdown.style.display === 'block' ? 'none' : 'block';
    }
    
    function setLanguage(lang) {
        // Update content with selected language
        document.querySelectorAll('[data-lang-tr], [data-lang-en]').forEach(el => {
            el.innerHTML = el.getAttribute(`data-lang-${lang}`);
        });
        
        // Update flag and language name in button
        document.getElementById("selected-flag").src = lang === "tr" ? 
            "https://flagcdn.com/w40/tr.png" : "https://flagcdn.com/w40/gb.png";
        document.getElementById("selected-lang").textContent = lang === "tr" ? "Türkçe" : "English";
        
        // Update language dropdown options based on current language
        const trOption = document.getElementById("lang-option-tr");
        const enOption = document.getElementById("lang-option-en");
        
        if (lang === "tr") {
            trOption.innerHTML = '<img src="https://flagcdn.com/w40/tr.png" alt="TR"> Türkçe';
            enOption.innerHTML = '<img src="https://flagcdn.com/w40/gb.png" alt="EN"> İngilizce';
        } else {
            trOption.innerHTML = '<img src="https://flagcdn.com/w40/tr.png" alt="TR"> Turkish';
            enOption.innerHTML = '<img src="https://flagcdn.com/w40/gb.png" alt="EN"> English';
        }
        
        languageDropdown.style.display = 'none';
    }

    // Add click event listener to language button
    languageButton.addEventListener('click', function(event) {
        event.stopPropagation();
        toggleDropdown();
    });

    // Add event listener to close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (!languageButton.contains(event.target) && !languageDropdown.contains(event.target)) {
            languageDropdown.style.display = 'none';
        }
    });

    window.setLanguage = setLanguage;
    setLanguage('tr'); // Default language

    // Contact form submission - Web3Forms entegrasyonu
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            let isValid = true;
            
            // Validate all form fields
            this.querySelectorAll('input:not([type="hidden"]), textarea').forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = 'red';
                } else {
                    input.style.borderColor = '#ddd';
                }
            });

            if (!isValid) {
                // Show validation error message
                const currentLang = document.getElementById("selected-lang").textContent === "Türkçe" ? "tr" : "en";
                const validationMessage = currentLang === "tr" ? 
                    'Lütfen tüm alanları doldurun.' : 
                    'Please fill in all fields.';
                
                alert(validationMessage);
                return; // Stop execution if validation fails
            }

            // Show loading state
            const submitButton = this.querySelector('button[type="submit"]');
            const originalText = submitButton.innerHTML;
            submitButton.disabled = true;
            submitButton.innerHTML = document.getElementById("selected-lang").textContent === "Türkçe" ? 'Gönderiliyor...' : 'Sending...';
            
            // Web3Forms kullanarak form gönderimi
            const formData = new FormData(this);
            
            fetch('https://api.web3forms.com/submit', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Form başarıyla gönderildi
                    const currentLang = document.getElementById("selected-lang").textContent === "Türkçe" ? "tr" : "en";
                    const successMessage = currentLang === "tr" ? 
                        'Mesajınız başarıyla gönderildi! En kısa sürede size dönüş yapacağız.' : 
                        'Your message has been sent successfully! We will get back to you soon.';
                    
                    alert(successMessage);
                    contactForm.reset();
                } else {
                    // Form gönderiminde hata oluştu
                    throw new Error('Form submission failed');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                const currentLang = document.getElementById("selected-lang").textContent === "Türkçe" ? "tr" : "en";
                const errorMessage = currentLang === "tr" ? 
                    'Mesaj gönderilirken bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.' : 
                    'An error occurred while sending the message. Please try again later.';
                
                alert(errorMessage);
            })
            .finally(() => {
                submitButton.disabled = false;
                submitButton.innerHTML = originalText;
            });
        });
    }

    // Tema değiştirme fonksiyonu
    function toggleTheme() {
        const body = document.body;
        const darkIcon = document.getElementById('dark-icon');
        const lightIcon = document.getElementById('light-icon');
        
        // Koyu tema sınıfını ekle/kaldır
        body.classList.toggle('dark-mode');
        
        // İkonları değiştir
        if (body.classList.contains('dark-mode')) {
            darkIcon.style.display = 'none';
            lightIcon.style.display = 'block';
            localStorage.setItem('theme', 'dark');
        } else {
            darkIcon.style.display = 'block';
            lightIcon.style.display = 'none';
            localStorage.setItem('theme', 'light');
        }
    }

    // Tema değiştirme düğmesine olay dinleyici ekle
    document.getElementById('theme-toggle-btn').addEventListener('click', toggleTheme);

    // Sayfa yüklendiğinde kaydedilen temayı kontrol et
    
});