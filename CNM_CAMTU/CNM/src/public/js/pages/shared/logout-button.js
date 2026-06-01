document.addEventListener("DOMContentLoaded", () => {

    const logoutBtn = document.getElementById("logoutBtn");

    if (!logoutBtn) return;

    logoutBtn.addEventListener("click", async (e) => {
        e.preventDefault();
        e.stopPropagation();

        if (!confirm("Bạn có chắc muốn đăng xuất?")) return;

        try {
            const res = await fetch("/api/auth/logout", {
                method: "POST",
                credentials: "include"
            });

            const data = await res.json();

            if (data.success) {
                localStorage.removeItem("user");
                window.location.replace("/login");
            }

        } catch (err) {
            console.error("Logout error:", err);
        }
    });

});