import Image from "next/image";
import Link from "next/link";

export const LOGO_PATH = "/images/logo/nurse-rocky-logo.png";
export const LOGO_WIDTH = 1009;
export const LOGO_HEIGHT = 410;

type BrandLogoProps = {
  href?: string | null;
  className?: string;
  height?: number;
  priority?: boolean;
};

export function BrandLogo({
  href = "/",
  className = "",
  height = 150,
  priority = false,
}: BrandLogoProps) {
  const img = (
    <Image
      src={LOGO_PATH}
      alt="Nurse Rocky Institute"
      width={LOGO_WIDTH}
      height={LOGO_HEIGHT}
      priority={priority}
      className="brand-logo__img"
      style={{ height: `${height}px`, width: "auto" }}
    />
  );

  const classes = ["brand-logo", className].filter(Boolean).join(" ");

  if (href) {
    return (
      <Link href={href} className={classes}>
        {img}
      </Link>
    );
  }

  return <span className={classes}>{img}</span>;
}
