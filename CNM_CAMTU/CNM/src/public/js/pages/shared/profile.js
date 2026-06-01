// /* =========================================================
//    PROFILE PAGE LOGIC
// ========================================================= */

// document.addEventListener('DOMContentLoaded', () => {

//     initProfilePage();

// });

/* =========================================================
   INIT
========================================================= */

function initProfilePage() {

    animateProfileCard();

    setupAvatarHover();

    setupBadgeEffect();

    setupResponsiveCheck();

    formatAllDates();

    console.log('✅ Profile page initialized');

}

/* =========================================================
   PROFILE CARD ANIMATION
========================================================= */

function animateProfileCard() {

    const sidebar = document.querySelector('.profile-sidebar');

    const content = document.querySelector('.profile-content');

    if (sidebar) {

        sidebar.style.opacity = '0';
        sidebar.style.transform = 'translateY(30px)';

        setTimeout(() => {

            sidebar.style.transition =
                'all 0.5s ease';

            sidebar.style.opacity = '1';

            sidebar.style.transform =
                'translateY(0)';

        }, 100);

    }

    if (content) {

        content.style.opacity = '0';
        content.style.transform = 'translateY(30px)';

        setTimeout(() => {

            content.style.transition =
                'all 0.7s ease';

            content.style.opacity = '1';

            content.style.transform =
                'translateY(0)';

        }, 250);

    }

}

/* =========================================================
   AVATAR EFFECT
========================================================= */

function setupAvatarHover() {

    const avatar = document.querySelector(
        '.profile-avatar'
    );

    if (!avatar) return;

    avatar.addEventListener('mouseenter', () => {

        avatar.style.transform = 'scale(1.05)';
        avatar.style.transition = '0.3s';

    });

    avatar.addEventListener('mouseleave', () => {

        avatar.style.transform = 'scale(1)';

    });

}

/* =========================================================
   BADGE EFFECT
========================================================= */

function setupBadgeEffect() {

    const badges = document.querySelectorAll(
        '.badge'
    );

    badges.forEach((badge) => {

        badge.addEventListener('mouseenter', () => {

            badge.style.transform =
                'translateY(-3px)';

            badge.style.transition =
                '0.2s ease';

        });

        badge.addEventListener('mouseleave', () => {

            badge.style.transform =
                'translateY(0)';

        });

    });

}

/* =========================================================
   RESPONSIVE CHECK
========================================================= */

function setupResponsiveCheck() {

    window.addEventListener('resize', () => {

        const width = window.innerWidth;

        if (width < 768) {

            console.log('📱 Mobile mode');

        } else {

            console.log('💻 Desktop mode');

        }

    });

}

/* =========================================================
   FORMAT DATE DISPLAY
========================================================= */

function formatAllDates() {

    const dateElements =
        document.querySelectorAll('[data-date]');

    dateElements.forEach((element) => {

        const rawDate =
            element.getAttribute('data-date');

        if (!rawDate) return;

        const date = new Date(rawDate);

        element.innerText =
            date.toLocaleDateString('vi-VN');

    });

}

/* =========================================================
   COPY EMAIL
========================================================= */

function setupCopyEmail() {

    const emailBox = document.querySelector(
        '.email-copy'
    );

    if (!emailBox) return;

    emailBox.addEventListener('click', async () => {

        try {

            const email =
                emailBox.innerText.trim();

            await navigator.clipboard.writeText(
                email
            );

            showToast('📧 Email copied');

        } catch (err) {

            console.error(err);

        }

    });

}
/* =========================================================
   TOAST
========================================================= */

function showToast(message) {

    const toast = document.createElement('div');

    toast.className = 'custom-toast';

    toast.innerText = message;

    document.body.appendChild(toast);

    setTimeout(() => {

        toast.classList.add('show');

    }, 100);

    setTimeout(() => {

        toast.classList.remove('show');

        setTimeout(() => {

            toast.remove();

        }, 300);

    }, 2500);

}

/* =========================================================
   START
========================================================= */

document.addEventListener('DOMContentLoaded', () => {

    initProfilePage();

    setupCopyEmail();

});