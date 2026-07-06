import Image from "next/image";
import Link from "next/link";

export const LOGO_PATH = "/images/logo/nurse-rocky-logo.png";
export const LOGO_WIDTH = 1009;
export const LOGO_HEIGHT = 410;

export const LOGO_DARK_PATH = "/images/logo/nurse-rocky-logo-dark.png";
export const LOGO_DARK_WIDTH = 918;
export const LOGO_DARK_HEIGHT = 299;

type BrandLogoProps = {
  href?: string | null;
  className?: string;
  height?: number;
  priority?: boolean;
  /** Use the light/white logo asset on dark backgrounds (footer, sidebars, auth panels). */
  variant?: "default" | "dark";
};

export function BrandLogo({
  href = "/",
  className = "",
  height = 150,
  priority = false,
  variant = "default",
}: BrandLogoProps) {
  const isDark = variant === "dark";
  const src = isDark ? LOGO_DARK_PATH : LOGO_PATH;
  const intrinsicWidth = isDark ? LOGO_DARK_WIDTH : LOGO_WIDTH;
  const intrinsicHeight = isDark ? LOGO_DARK_HEIGHT : LOGO_HEIGHT;

  const img = (
    <Image
      src={src}
      alt="Nurse Rocky Institute"
      width={intrinsicWidth}
      height={intrinsicHeight}
      priority={priority}
      className="brand-logo__img"
      style={{ height: `${height}px`, width: "auto" }}
    />
  );

  const classes = ["brand-logo", isDark ? "brand-logo--dark" : "", className]
    .filter(Boolean)
    .join(" ");

  if (href) {
    return (
      <Link href={href} className={classes}>
        {img}
      </Link>
    );
  }

  return <span className={classes}>{img}</span>;
}
