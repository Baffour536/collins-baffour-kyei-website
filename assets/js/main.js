(() => {
  const menuButton = document.querySelector('.menu-button');
  const navLinks = document.querySelector('.nav-links');

  if (menuButton && navLinks) {
    menuButton.addEventListener('click', () => {
      const open = menuButton.getAttribute('aria-expanded') === 'true';
      menuButton.setAttribute('aria-expanded', String(!open));
      navLinks.classList.toggle('open', !open);
      document.body.classList.toggle('menu-open', !open);
    });

    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        menuButton.setAttribute('aria-expanded', 'false');
        navLinks.classList.remove('open');
        document.body.classList.remove('menu-open');
      });
    });
  }

  const reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window && !window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    const observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.08 });
    reveals.forEach(el => observer.observe(el));
  } else {
    reveals.forEach(el => el.classList.add('visible'));
  }

  document.querySelectorAll('[data-current-year]').forEach(el => {
    el.textContent = new Date().getFullYear();
  });

  const form = document.querySelector('[data-mailto-form]');
  if (form) {
    form.addEventListener('submit', event => {
      event.preventDefault();
      const data = new FormData(form);
      const name = `${data.get('firstName') || ''} ${data.get('lastName') || ''}`.trim();
      const purpose = data.get('purpose') || 'Website enquiry';
      const organisation = data.get('organisation') || 'Not specified';
      const email = data.get('email') || '';
      const message = data.get('message') || '';
      const subject = encodeURIComponent(`${purpose} — website enquiry from ${name || 'visitor'}`);
      const body = encodeURIComponent(
        `Name: ${name}\nEmail: ${email}\nOrganisation: ${organisation}\nPurpose: ${purpose}\n\n${message}`
      );
      window.location.href = `mailto:collinskb536@gmail.com?subject=${subject}&body=${body}`;
    });
  }

  const courseFilterButtons = document.querySelectorAll('[data-course-filter]');
  const courseCards = document.querySelectorAll('[data-course-level]');
  if (courseFilterButtons.length && courseCards.length) {
    courseFilterButtons.forEach(button => {
      button.addEventListener('click', () => {
        const selected = button.dataset.courseFilter;
        courseFilterButtons.forEach(item => item.classList.toggle('active', item === button));
        courseCards.forEach(card => {
          card.hidden = selected !== 'all' && card.dataset.courseLevel !== selected;
        });
      });
    });
  }

})();
