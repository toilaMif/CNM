const jwt = require('jsonwebtoken');

const authRepo =
    require('../../modules/auth/auth.repository');

const ACCESS_SECRET =
    process.env.ACCESS_TOKEN_SECRET;

const REFRESH_SECRET =
    process.env.REFRESH_TOKEN_SECRET;

/* =========================================================
   COOKIE CONFIG
========================================================= */

const COOKIE_OPTIONS = {

    httpOnly: true,

    secure:
        process.env.NODE_ENV === 'production',

    sameSite: 'Lax',

    path: '/',
};

const ACCESS_COOKIE_OPTIONS = {

    ...COOKIE_OPTIONS,

    maxAge: 15 * 60 * 1000,
};

/* =========================================================
   GENERATE ACCESS TOKEN
========================================================= */

function generateAccessToken(user) {

    return jwt.sign(

        {
            id: user.id,

            role_name: user.role_name,
        },

        ACCESS_SECRET,

        {
            expiresIn: '15m',
        }
    );
}

/* =========================================================
   VERIFY PAGE AUTH
========================================================= */

async function verifyPageAuth(
    req,
    res,
    next
) {

    try {

        /* =============================================
           ACCESS TOKEN
        ============================================= */

        const accessToken =
            req.cookies?.accessToken;

        if (accessToken) {

            try {

                const decoded =
                    jwt.verify(
                        accessToken,
                        ACCESS_SECRET
                    );

                req.user = decoded;

                return next();

            } catch (err) {

                // token expired
            }
        }

        /* =============================================
           REFRESH TOKEN
        ============================================= */

        const refreshToken =
            req.cookies?.refreshToken;

        if (!refreshToken) {

            return res.redirect(
                '/login'
            );
        }

        /* =============================================
           VERIFY REFRESH TOKEN
        ============================================= */

        let payload;

        try {

            payload = jwt.verify(
                refreshToken,
                REFRESH_SECRET
            );

        } catch {

            return res.redirect(
                '/login'
            );
        }

        /* =============================================
           GET USER
        ============================================= */

        const user =
            await authRepo.findById(
                payload.id
            );

        if (!user) {

            return res.redirect(
                '/login'
            );
        }

        /* =============================================
           GENERATE NEW ACCESS TOKEN
        ============================================= */

        const newAccessToken =
            generateAccessToken(user);

        /* =============================================
           SET NEW COOKIE
        ============================================= */

        res.cookie(
            'accessToken',
            newAccessToken,
            ACCESS_COOKIE_OPTIONS
        );

        req.user = {

            id: user.id,

            role_name:
                user.role_name,
        };

        next();

    } catch (err) {

        console.error(err);

        return res.redirect(
            '/login'
        );
    }
}

module.exports = {
    verifyPageAuth
};